Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3773ADBA2
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134930; cv=none; b=XX/+THLlcDmYJlsTDTuK4356kTbWfrEVXHFeQz6cae8egLaG4VTXbWnyw3501o6dWOLt/2JJf31wk8OA882gRguOJGpU8okOeyuppsQnrfXsPEkx8SLKUr02XdwmpcOxNUc1BEyy50T7lO8PVaO0Y2kt0vKQOijgvcPF28/QJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134930; c=relaxed/simple;
	bh=S0Yxbr3Oly4NxwB+pjST5uotYybs+B5l8Bl4GHmf3Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ejWCcKWBl1Gl7fVMLBnSKjRooQqZHAmCH2GI2Jhfguc5v98PrnNn01Yl2Pf0De8a+kl/yTxD8OvazkoiiRHc1FBbEQxS5j8gx9B/1PaVkIwTEEo8/KXc7AIqCc7gVty48D0emawRxncPDXN0/3LJwgyAe62t+oQTFWSYSHDp6nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=NR67Avp3; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="NR67Avp3"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 557A13AC;
	Wed, 15 Jul 2026 17:02:17 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=NR67Avp3;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id C6A291D36;
	Wed, 15 Jul 2026 17:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1784134925;
	bh=ifYoBniFYceQ7YrtrsTUuFuzBWUm1R6fJ5mlgRMnJpo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NR67Avp3rapF26iWgPxGnwQFfsww3rj/oGuZ4beJJg5TlvtwEpRhoczYJ7RKeGrAA
	 iZ5Q7Xs3ll8tCk6lE040AqU3zyNQNnPVjRfNd0F1FT/pGQE0rYDJClPeaDeoGaf7L+
	 M8taCgjx211eeJySM+bmNMZ2nVeTPWHeT5bWevYc=
Received: from [192.168.95.128] (172.30.20.151) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Jul 2026 20:02:04 +0300
Message-ID: <abf5663b-68a3-45d4-b6a2-375d99fe61b0@paragon-software.com>
Date: Wed, 15 Jul 2026 19:02:03 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ntfs3: fix boundary check in ntfs_dir_count()
To: Xixin Liu <liuxixin@kylinos.cn>, <linux-fsdevel@vger.kernel.org>
CC: <kari.argillander@gmail.com>
References: <cover.ntfs3-b1-v1.1780449274.git.liuxixin@kylinos.cn>
 <9211aa31fd02d45e42b4981497c6572ad8e26144.1780449274.git.liuxixin@kylinos.cn>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <9211aa31fd02d45e42b4981497c6572ad8e26144.1780449274.git.liuxixin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 6/9/26 04:29, Xixin Liu wrote:

> ntfs_dir_emit() skips index entries whose fname does not fit in e->size,
> but ntfs_dir_count() still accepted them via de_get_fname() alone.
> dir_is_empty() can then disagree with readdir: a malformed directory
> appears empty in ls while rmdir fails with ENOTEMPTY.
>
> Factor the fname/key bounds check into de_fname_fits() and use it from
> ntfs_dir_emit() and de_countable_fname() so count/readdir share the same
> entry acceptance rules.
>
> Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
> ---
>   fs/ntfs3/dir.c | 33 ++++++++++++++++++++++++++-------
>   1 file changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
> index 873d52233003..eda02b46e9ed 100644
> --- a/fs/ntfs3/dir.c
> +++ b/fs/ntfs3/dir.c
> @@ -273,6 +273,13 @@ struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
>          return err == -ENOENT ? NULL : err ? ERR_PTR(err) : inode;
>   }
>
> +
> +static inline bool de_fname_fits(const struct NTFS_DE *e, u32 e_size,
> +                                const struct ATTR_FILE_NAME *fname)
> +{
> +       return sizeof(struct NTFS_DE) + fname_full_size(fname) <= e_size;
> +}
> +
>   /*
>    * returns false if 'ctx' if full
>    */
> @@ -305,9 +312,7 @@ static inline bool ntfs_dir_emit(struct ntfs_sb_info *sbi,
>          if (sbi->options->nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
>                  return true;
>
> -       if (sizeof(struct NTFS_DE) +
> -           offsetof(struct ATTR_FILE_NAME, name) +
> -           fname->name_len * sizeof(short) > le16_to_cpu(e->size))
> +       if (!de_fname_fits(e, le16_to_cpu(e->size), fname))
>                  return true;
>
>          name_len = ntfs_utf16_to_nls(sbi, fname->name, fname->name_len, name,
> @@ -576,6 +581,23 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
>          return err;
>   }
>
> +
> +/*
> + * Return fname when @e passes the same checks as ntfs_dir_emit() before
> + * exposing an entry (valid key, non-DOS, fname fits in e->size).
> + */
> +static inline const struct ATTR_FILE_NAME *
> +de_countable_fname(const struct NTFS_DE *e, u32 e_size)
> +{
> +       const struct ATTR_FILE_NAME *fname;
> +
> +       fname = de_get_fname(e);
> +       if (!fname || fname->type == FILE_NAME_DOS || !de_fname_fits(e, e_size, fname))
> +               return NULL;
> +
> +       return fname;
> +}
> +
>   static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
>                            size_t *files)
>   {
> @@ -615,13 +637,10 @@ static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
>                          if (de_is_last(e))
>                                  break;
>
> -                       fname = de_get_fname(e);
> +                       fname = de_countable_fname(e, e_size);
>                          if (!fname)
>                                  continue;
>
> -                       if (fname->type == FILE_NAME_DOS)
> -                               continue;
> -
>                          if (is_empty) {
>                                  *is_empty = false;
>                                  if (!dirs && !files)
> --
> 2.43.0
>
Hello,

Very sorry for the delay.
Your patch was applied, thank you.

Regards,
Konstantin

