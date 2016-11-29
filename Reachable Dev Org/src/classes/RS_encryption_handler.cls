public with sharing class RS_encryption_handler
{
    public static Blob exampleIv = Blob.valueOf('DgUEhICfth3BRO95');
    public static String keyval  = 'CgAwIBAgIEyzhv61';
    public static String value;
    public static Blob key = Blob.valueOf(keyval);
    
    public static String encrypt(String accesstoken)
    {
        Blob data = Blob.valueOf(accesstoken);
        Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);
        String enc = EncodingUtil.base64Encode(encrypted);
        value = enc;
        return value;
    }
    
    public static String decrypt(String accesstoken)
    {
        Blob datastring = EncodingUtil.base64Decode(accesstoken);
        Blob decrypted = Crypto.decrypt('AES128', key, exampleIv, datastring);
        String decryptedString = decrypted.toString();
        value = decryptedString;
        return value;
    }
}