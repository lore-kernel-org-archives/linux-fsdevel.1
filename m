Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792534864;
	b=d7QJO0L8wboikgSpBNGiCbX2XlFvBEqQGARL6/fjMUiGMGCqcbFAGxKO/ud0l5RoBiVP
	 HrPgSsgrkGAnT+oSqJ6c1kf1JGg0qhP0pXs2G5ZnoxUBs8H8U9TYZy+XRm9wtWvxy+Iga
	 ueL28kR48bxDtd1cB54AbrjQu5KxF06hyH7Dtil8WDvGQqqPOEDFAaf+d4cnO1ev4zNtj
	 ST9UNAq8+Rvcmz5HWWlBmTzF71x3riJBOs7dCoca3qyV6RqeuD6QG90MYPIzrnMVWMP4a
	 VlxFdkUo2iNBWTYVr/EVhMFQfeFgCvGjqU1pEYcc2xa/txLxJ4NNbN7th1/zREfXqiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792534864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=pghdpTVdNq2MZRY0h0Gn+vje5VJFjDa/Zt8muo4zdOA=;
	b=FTtvCVVNqxaj6iVnmgCeUTm2mFU3S+wPGZwf2DmUzZMn2SGGcdiDx41s9bzJGfbhl6kh
	 8Ryc+THphFgB97evzh9OIR+rTcrJK3p9GzYw/8xCN2OnSdPmIDw3FxoHnlyG9KhI+MNvV
	 hQcLNDAjYO+SdekxDeiGphdFRtpbP/LVLDW7dEM87rgxOjDL7PAyqi5OSMQnIjCAZpzCv
	 0FbWI54FFSbLfURuH1wCs+ENGZLUq+V2D/9caeKremA9kqdCWgxssQcDP3a4dG3/tlZaI
	 dtrg4rEXzqpyS/UPt8H6JvmPz0sW+t/YJ4MITs7sKtsbQK1NHhjaVj9thkR7AF/vGjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=vngB984g;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70C6606A31B
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 22:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A70C6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=vngB984g
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b0d63f60bcso1206367b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 15:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792534862; x=1793139662; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pghdpTVdNq2MZRY0h0Gn+vje5VJFjDa/Zt8muo4zdOA=;
        b=vngB984guw4e/6yXsRFA0mI/1yvZR6zowP/Vyp8TvEB+TLQfLP0noNJy75rnmfeuwc
         CCyvpm4I+jis5wvfVr8vDph1j/EgYVKQF546Upf7Y1E1DhL+2LGOKiJ52PbNwlSINjVQ
         qsiX1XMyygB8vwGOGiwB8s4A2mJ65FCO/sRQZ+c5qZpeezuUN1JQiTb3H8v+IRBb7HzW
         JTE5BZ3/FoZVuJ8Ui6gMuO2wup7/sBWyFW/I7rTuzANgC3S6eZlraTJi6azIPctLLVIm
         ZzZoLUJEMvwwn92r1dt4fLDOiXezmkOc6KD0RHgJ5V1Fs1GLPjW1gQccZgPb3BiO/SLv
         3AVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792534862; x=1793139662;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pghdpTVdNq2MZRY0h0Gn+vje5VJFjDa/Zt8muo4zdOA=;
        b=eb4ZJQNukFo4SQozs9in77gTuNVzwmdfQx0lL0mFpuOXRuzqwT/ZB4t89KKjKxFT9E
         TAim/PHGU2O4zU/RSEi2xeKMWikCZWq9YXJGCJleBbAyA24Qtw80XAXQCGAE9aU5gnGv
         GPnhRiv+NRq9z9akisnJQEh4OHGuvBxCmuVJNwzikZi4Owll6lMwGlHI+Q/v+XI+DZhk
         edZ5o7XeNV7p5BidwHTCZ9zdQ7Yx7HCgD8pnaHKnWniOmGay8jOv4Ol6BvEQYqSMFamZ
         aAeSWHtd34fBVKbo26B+agMbUEt1W4rH8/vwONFvTIpZiT1LCCGVpK7iVGsAuJG4rsZM
         T+zA==
X-Gm-Message-State: AFq9FYJKIpHae7jfzxmnAVzvGgg8KNbl2D2SFTUqocXyIqPVKTCoEuyg
	XXQBWsvdym5/I0XSQA4nMMzCsd34KL6jrcTGSLExU3CEmPFrZfd/YZp+fDb/xmo+hVM=
X-Gm-Gg: AYBFou13ygxtVciJmlw8HwyD+fkxVln7xgsbHWH2FNKxmuPDWWXEWYX6X/r2hAJ5l7L
	OUACTSZ9snntG2pQulCRtQORF8CeswHmFbIh/2eJyHiA6/RwDkMs15pagI7PfMVYLiJA77uzEjj
	sx278HRSgKnmfN3XI7+GhL//uu9agxwfvTaN30J2szPVWEbMnNURS8tsvjoI9mxLCYGzh8vxYW0
	ze87SZQ6pJgRKdF1yC1bsplvj157T9XrzncG90N7bJLNfd/sdIzZwPzuV0dls4jrD+8bQdC5UiO
	IiGPU9x+vc6bvNbX7QfgTM9/K80OCuNpTrOVgcS+IAwL161Bxk06M4KkTupudYY4Gmi90boQ234
	dfEMIxEZb1zf7E6kBXZbFyRArHTzxUq0JzLj6rLTTondk/4krOFzVN6KxZVdBBTTv7+8CuzLEMI
	Cj1RWOxnuCIUbuXCPfuySiNwfa+tV/ejDUb4eT/KD6lER6SAM1Scx+PLlkqdIIZbbsYl7SASjkJ
	/sXAJ9AEnj7cVeF5U/nGpQGY5noOk/JA+ekSoQFxAWMx8YfUmpYrwYYcMVDfAVI0rkeLD5XhVG7
	XeXeo9GRHtytTtWVGnOoA1pGa9z7
X-Received: by 2002:a05:690c:6e84:b0:8b0:d75a:9cf8 with SMTP id 00721157ae682-8b133d2a29fmr1910447b3.41.1792534862540;
        Tue, 20 Oct 2026 15:21:02 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9597:5848:ae16:6bc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b13012f929sm3810567b3.33.2026.10.20.15.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 15:21:02 -0700 (PDT)
Message-ID: <74392849b266368d821d6dcaae4eda5d459d2e22.camel@dubeyko.com>
Subject: Re: [PATCH v6 2/2] hfs: return ERR_PTR() from hfs_iget()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: yangguikun <yangguikun19@qq.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 15:21:00 -0700
In-Reply-To: <tencent_190DA969DF79232C4E2FA681510C3E365108@qq.com>
References: <tencent_190DA969DF79232C4E2FA681510C3E365108@qq.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-10-20 at 18:19 +0800, yangguikun wrote:
> hfs_iget() returns NULL both for corrupted catalog records and for
> allocation failures, so the callers cannot tell them apart:
> hfs_lookup()
> reports every case as -EACCES and hfs_fill_super() as -EINVAL.
>=20
> Return ERR_PTR(-EIO) for the corruption cases and ERR_PTR(-ENOMEM)
> when
> the inode cannot be allocated, the same way minix_iget() does, and
> let
> the callers propagate the error.
>=20
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Signed-off-by: yangguikun <yangguikun19@qq.com>
>=20
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index e1f1fb3..0834d40 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -35,8 +35,6 @@ static struct dentry *hfs_lookup(struct inode *dir,
> struct dentry *dentry,
> =C2=A0			inode =3D ERR_PTR(res);
> =C2=A0	} else {
> =C2=A0		inode =3D hfs_iget(dir->i_sb, &fd.search_key->cat,
> &rec);
> -		if (!inode)
> -			inode =3D ERR_PTR(-EACCES);
> =C2=A0	}
> =C2=A0	hfs_find_exit(&fd);
> =C2=A0	return d_splice_alias(inode, dentry);
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index a66de7b..d28fbbd 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -484,15 +484,6 @@ struct inode *hfs_system_iget(struct super_block
> *sb, u32 cnid)
> =C2=A0	return inode;
> =C2=A0}
> =C2=A0
> -/*
> - * __hfs_iget()
> - *
> - * Given the MDB for a HFS filesystem, a 'key' and an 'entry' in
> - * the catalog B-tree and the 'type' of the desired file return the
> - * inode for that file/directory or NULL.=C2=A0 Note that 'type'
> indicates
> - * whether we want the actual file or directory, or the
> corresponding
> - * metadata (AppleDouble header file or CAP metadata file).
> - */
> =C2=A0struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key
> *key, hfs_cat_rec *rec)
> =C2=A0{
> =C2=A0	struct hfs_iget_data data =3D { key, rec };
> @@ -507,15 +498,17 @@ struct inode *hfs_iget(struct super_block *sb,
> struct hfs_cat_key *key, hfs_cat_
> =C2=A0		cnid =3D be32_to_cpu(rec->file.FlNum);
> =C2=A0		break;
> =C2=A0	default:
> -		return NULL;
> +		return ERR_PTR(-EIO);
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!hfs_is_valid_cnid(cnid, rec->type) ||
> =C2=A0	=C2=A0=C2=A0=C2=A0 hfs_is_system_reserved_cnid(cnid))
> -		return NULL;
> +		return ERR_PTR(-EIO);
> =C2=A0
> =C2=A0	inode =3D iget5_locked(sb, cnid, hfs_test_inode,
> hfs_read_inode, &data);
> -	if (inode && (inode_state_read_once(inode) & I_NEW))
> +	if (!inode)
> +		return ERR_PTR(-ENOMEM);
> +	if (inode_state_read_once(inode) & I_NEW)
> =C2=A0		unlock_new_inode(inode);
> =C2=A0	return inode;
> =C2=A0}
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 5e6d66f..d201502 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -378,8 +378,10 @@ static int hfs_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	res =3D -EINVAL;
> =C2=A0	root_inode =3D hfs_iget(sb, &fd.search_key->cat, &rec);
> =C2=A0	hfs_find_exit(&fd);
> -	if (!root_inode)
> +	if (IS_ERR(root_inode)) {
> +		res =3D PTR_ERR(root_inode);
> =C2=A0		goto bail_no_root;
> +	}
> =C2=A0
> =C2=A0	if (is_bad_inode(root_inode)) {
> =C2=A0		iput(root_inode);

Looks good. I have run the xfstests for both patches and I don't see
any new issue.

Before the patch: Failed 121 of 786 tests
After the patch: Failed 117 of 786 tests

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Tested-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
