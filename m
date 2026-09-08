Received: from sonic313-22.consmr.mail.bf2.yahoo.com (sonic313-22.consmr.mail.bf2.yahoo.com [74.6.133.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384363CB54B
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909004; cv=none; b=p4Oe7464+YvG3JBwtANI0Ge9Xy60Q9ZxYNxFsOnSQVqGPlr58/t+igLviez/s9dTN91ZiHsR5ghJDSd9+e8TfAq2vlRd7kDki89sRVhQdY+WTA5UKUsnhAyxbIB2NWEjWv5zrub1JOkt79V94RwIqL1tifRUMQZ4znHSU35QP9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909004; c=relaxed/simple;
	bh=4aMvBaJfE6F6X8XAozVCxG84SSG/m3fXQl1EgHroo+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+A1Tj8U6mnxR0k1e0DzhyDfvfvnlaxGp56i1HNsby5ZuSe+XKaBO+5x9hKM+e6tO5pFhHcPlfELeJCBDdmAYMCWu3ff3Zqn6gwS3ly0iZZ16DTrugCACLW9WAm7483+650ZAdQhXVasbSWIM8V09FBfCWnPuiOWbiPwEGMvmxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LHDUXBRK; arc=none smtp.client-ip=74.6.133.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LHDUXBRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1788909001; bh=bNavbKXoeelFxomRONrX7NRcXGbrLs2sTeCQZ/9x9WE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=LHDUXBRKGdYMbz+PfCUxDDRDobsdZJ9mobxUm72LoraMz/2kgXSORhB/HVvaYKUhbCJ9z8eP0VjNNbumW4eMInEQ/cE4qpMnxG4EHzS4NLT/Yd87n5Mc3FmsE2Gzx0qxuLCLZYeM9SVGxiXTifLg2j09+AEUbHTT4u1vI/zQKAfnT3WfEEWeev47mpSIvjtdlDcrNFLR9W9xznSG0p8DcLTYQG8pj/HxZkRX/fP6c/JqDatjXRQkBAbFDB6iSiWJhmr/ImcmM9zTCNsnWZKZwlJaTKJpIFm0upeeqwYJSYs2CM+vUVYqtyKa0iF3yYGnRObCWin37bchhi8cKWjxVg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1788909001; bh=+O8ZHcnOlqbqRkHpPLnwxy/QX9Ra8dghvV8Vah+TQ6f=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HDCP3ISda7SK/+Pp+uijUP4lEC1EQT1gxg3p4AtvSc/ecYFmBYFk5OTF8TVK+TCUWuFKRqKm5H73iR+SbDHOCIElryVPBuQTlz0U87RynPG/jGQngGfrDHbNPcvTo9RA4LJiS+8NM4YwcBz3eg4sqM4c8W0LoXGTA+y166wKbfMgqNFxlwZ/ZpZsRXd7CWgDQAZlp5we6CfD7bTOJ0wy6eMRqSB8j0NOTOFKjTlaMCVv+Wv1V0wKDOa0hW+EXa5WsMypty1r5Sc7O0L72EpXL2mnWWPw4UrRUw2EbRqsTj9exagDY2ffE5mfN5Q/lnA8m+wn42oXbuVNN8fzSxyOVw==
X-YMail-OSG: TrdP450VM1nkRNToY09DfpMIhr9rz4ZnjyFwZiIWDsi6czussYfvBXPNU3RSC0l
 6OoozMRFSBbPH9xQE.rSHnJDkPKE.nNesm9FSmMAkbv4I6xZd2ZR8y_8R.ZXvVxlQzM7gYhYMild
 f2ajo9bgl9JIZfLSlAigtDBSeAg_Y6jg3ruKQOGor8hrqleMy2vCx7I2zOl.OewgxsADHTkiDZdw
 FkcEssdhqyrocYIgPCQVOp94.WihT53IR9LJR9wS00eCpougYJZna.dSV5Tgt5y6iwL_0fqjwWS8
 lw_vfBFO2z_tEfCc2i9sNGTMJe9NowvmEA8Xf.7BdANFQbqvRKxzbq_ezoxR2Lv0TiJGsH6pLhWl
 a3Sq5vOueupsZ260PXc26LOlcuyho5w3I6a16.ZnP1_6wsTObuBr97jCaH0jfSeg.wo.UAO7eINE
 PtxH3JqBy3lk3XCJ9aIBDmBUvzHWSXhA8wKZrexZtidjib4oRoB4PJwDpMKYOiZeBNyXfy3pOhlW
 PLISeRcv6uLT0Yh6zlKSUmiSFIk4vIN78XMSjQhl6ncQYVtAzX0tEDYXfd6ExxMb9n.p0kTWpCTy
 uAx_WFx33DC944kh2qndd63WVvE6_QTZhchaOUsqoGD8RmorhJhohVkdi.rj2R4KXO.5wiQW8Qrm
 6HhMTZe2BiK0dlnM5YFzO8Bg_6k3TMaNBLEKplGXj.BlvqyczivX64RXVdL5yQgmeNFzkcHy09p.
 Saw.FEziugfOA8KHv4kQjPu6zlmCstnD68d7AmZtfi857P13BNxiRMoTVhdtyNlj4z7O2MLd0J3w
 SWpTxLbmZEMIC8iY6nGdv3DNpttbJqIdaxbrN4W3y8.tCg.hJx6X9iUzLyBkKpbGW7N4dpNNI72i
 I6pWyrCypE119R3h0h1Mt4dMU.TUwE7xjyJ3nAqYqURHIgaywDMmMH0VSX3f5KGDMrAj3l06_4xC
 SWeWZc2_N.LS2rmyC04OungQoL1t6IEe9rHxaOkAjpIWeD7MqsacuqQr8Go365qzIf3hzxwQv45P
 xVgxT3_WKgVYoMG3CyLHNnJhEEWP.A39kIIc1p8V6QSMD5AJAdDuTM2hkVqVvfit8U1bP1MayHLE
 qHbb5NbJqHdMzsibLX9783gSlo_N_NDY2MUjrCUCFkHRHw8wF49UUNbm5mp_.m.vLFl1qBS8zh4v
 nmwH5mrZFxuH.DnuNbseFnQyowewr0CmwoEBRlkLqoO.RXj6iUivyDTa.aQpyrkPU9WArEZG27.L
 i6mupOsSFs8zuarMZW0wmLFtB7cGf3VXqNzvqgrSHOVXRRe92RTZUtL.R3I788ycIf45kQQnN3f8
 Sa4NsyJUXD7GBz1YiHvPsBVoPYkAocsZFNsbE.HDUkJhC43o7v1WkAP6ag6.MMkzBmD0as1qxEaI
 TxKHjRXE7AzNJ14lgGKXafqM7UCpp1tOrTBVUbnfYGpv5JHFhVAsg2jO038I6HLfr5xuni0V67DK
 w3OPjZX8F2EK8hJZ0ebOmfOefTFOzwePd42eAA76.sr9X88bPcSHZS7WcE4.s.lyIckQ6STBNI2O
 6AxrUPAiztRRrWsU39dTl.WXeqZBPnoNc9ub6FKc3.7AyHEhCoa3E_5kz3KwZIlOQ8uAgQIlDakp
 Inbigzv5YUT02wUl2OAv71QkSTT255zC0svgMKeDba3vfUA_eUU3SXfvZelPsjlJM6TXtmG.kYyK
 wWm_kRz58g_Eech1vxHGQvcgHrZxjDUC.aJ2oBP2MFhE3lpsWNU76jnr89xaDOi6ceyW9hVMcLAo
 ghUAlyUHKbj9daEjqNwGxTk3S6S.qaa.dMBhJlBGimbvYW_6qrmby0ohlb.k2DjFwyBNvEAnqjhU
 8RiUV60AkEiclpSEDmmUSzdGAMU7aO2jiRVP2Jrwe6mDVd5LaeNcKG7W9qBZ5m35bfwmylJneyTY
 vhlgzLU.B17nh4sd8psiU8rmR5BdJQ3e8hRcZb6d38LHKky5eI2aIKCB0RjJ.0x526_0TpjjdTLX
 NK94FppxMT9BRv9iDdKQyx7mHCMI9tJzl4K1hEbDjbrUMWqayBx.n3ITKi3N0.zLkfhSvOUYNQx8
 jVe9yde96vrIWsdbyLAzkFPSTl1.9G0BapK38mvHojMxA6rs8dAiQwpa5tz.ArHqg8BqgGvP37pH
 s_h6pqQQuk8UeiQaEkpVykys0pMKS46aPQOovOyWpVRUCXWZHIQlezhhytR3.JIEbzKCQebSPy_H
 D1E9meija16iTkt6DqY5ZQQ3NXHL13aGRhN2zCHEWJ5oZFMvqu7nTkkwwCmobfTE_sky_ofpFZZA
 BabnJDJcoOw6rPH2zxkY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c69521be-aa4e-43e0-980b-a309878f083c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Tue, 8 Sep 2026 23:10:01 +0000
Received: by hermes--production-gq1-678d9dd684-pmtnp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d02b3757abb6ec718247a44806490ae3;
          Tue, 08 Sep 2026 22:27:27 +0000 (UTC)
Message-ID: <312cbf15-71d7-4fac-bee4-67fd237c5f5b@schaufler-ca.com>
Date: Tue, 8 Sep 2026 15:27:25 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] lsm: expose mount idmaps to inode hooks
To: Paul Moore <paul@paul-moore.com>, daan@amutable.com
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
 <20260904-lsm-mount-idmaps-v3-1-920a1963675d@amutable.com>
 <CAHC9VhS5q2=6p2bi5c7CZ3mutji1xiKR2eFKgJ9C+XZsYgky2g@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhS5q2=6p2bi5c7CZ3mutji1xiKR2eFKgJ9C+XZsYgky2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26460 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/8/2026 3:05 PM, Paul Moore wrote:
> On Fri, Sep 4, 2026 at 10:48 AM Daan De Meyer via B4 Relay
> <devnull+daan.amutable.com@kernel.org> wrote:
>> From: Daan De Meyer <daan@amutable.com>
>>
>> Pass the mount idmap through the create, link, symlink, mkdir, mknod,
>> and permission hooks. Update the in-tree security implementations and
>> non-VFS callers accordingly.
>>
>> Signed-off-by: Daan De Meyer <daan@amutable.com>
>> ---
>>  fs/cachefiles/security.c      |  4 +--
>>  fs/namei.c                    | 18 +++++++-------
>>  include/linux/lsm_hook_defs.h | 23 +++++++++--------
>>  include/linux/security.h      | 58 +++++++++++++++++++++++++------------------
>>  security/security.c           | 40 +++++++++++++++++------------
>>  security/selinux/hooks.c      | 19 +++++++++-----
>>  security/smack/smack_lsm.c    |  9 ++++---
>>  7 files changed, 100 insertions(+), 71 deletions(-)
> Casey, are you okay with the Smack changes (below)?

Yes, assuming the 80 character limit is adhered to.

>
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 8e88ac65fd7f..a45819d13c0d 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -1089,14 +1089,15 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>
>>  /**
>>   * smack_inode_link - Smack check on link
>> + * @idmap: idmap of the mount
>>   * @old_dentry: the existing object
>>   * @dir: unused
>>   * @new_dentry: the new object
>>   *
>>   * Returns 0 if access is permitted, an error code otherwise
>>   */
>> -static int smack_inode_link(struct dentry *old_dentry, struct inode *dir,
>> -                           struct dentry *new_dentry)
>> +static int smack_inode_link(struct mnt_idmap *idmap, struct dentry *old_dentry,
>> +                           struct inode *dir, struct dentry *new_dentry)
>>  {
>>         struct smack_known *isp;
>>         struct smk_audit_info ad;
>> @@ -1226,6 +1227,7 @@ static int smack_inode_rename(struct inode *old_inode,
>>
>>  /**
>>   * smack_inode_permission - Smack version of permission()
>> + * @idmap: idmap of the mount
>>   * @inode: the inode in question
>>   * @mask: the access requested
>>   *
>> @@ -1233,7 +1235,8 @@ static int smack_inode_rename(struct inode *old_inode,
>>   *
>>   * Returns 0 if access is permitted, an error code otherwise
>>   */
>> -static int smack_inode_permission(struct inode *inode, int mask)
>> +static int smack_inode_permission(struct mnt_idmap *idmap, struct inode *inode,
>> +                                 int mask)
>>  {
>>         struct superblock_smack *sbsp = smack_superblock(inode->i_sb);
>>         struct smk_audit_info ad;
>>
>> --
>> 2.54.0
