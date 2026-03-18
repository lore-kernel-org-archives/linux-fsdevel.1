Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6270830
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773793219; cv=none; b=lTILdSxSK4+A6v7ESLnvQwbw8byEyjlNiZD9XIGoj2Xh6x4uW3Oz9MHgkc9DSIH32l/GmpyotZESpSr8RjpV7iIU69qpd8ioel/e9oFKJ5YS1FYDs7h/TkkxQrmMUXJ/QlpykRKLEiK/H/6q+mXMR0v52V3ATFHxwkr+e6cpdBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773793219; c=relaxed/simple;
	bh=rqlzh8om3MppYlVzPQAKWahRKUryk2ZD1eiUMoHr0NY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PZD5nVz+UhsIG9lgtQhvZIjt15ZN/JvUW8oIyipzGim8iItglSUd7RrznzwSi8eztAiLZP+hVns0TYfHpvCB/pOnxRz1iS934SfYVWvvPGzpDNbtj8giTrn2m/CyV4vjiqLWIxW+ujOUjXwsQoBG0tIxWWLcIEk9EhbZlUr8r9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=AGq2LMd+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="AGq2LMd+"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82748257f5fso251387b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 17:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1773793217; x=1774398017; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leWzlXRjKUHn6Crlsk5+VQIAi7Gp+SzgyV5eBtNfjVU=;
        b=AGq2LMd+c+bnRwZ7VL3eTaVNH7hBrB26BABaBmvp4PqyO/pWX/moLOVSn0FrItXjPe
         w4Fox+WZ535pnFITAf+76mFlRkvnmPpLHF0heOnByeb6vh3kzH1oTbkVdRoCGKG1s05p
         MwZCJ8ZNrFxMSLIgJl6mZE7SG+CzcstbBV+zCn1HBDcJGo5YV/mWyXXrm85naqiSIrlA
         cJx1jpc+Y1+uChJn1K6t1g3kc0Za1vZ52Vcf/KVlKTaIP9CXUrZkjuxyQlPcfoonAXCP
         4ZnEzM0ySr62JzZSAcDbuPFSTYx8XVqSS0Gtrzkusq0BfXw+3ROuuiYwlNYOHARcQInB
         rKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773793217; x=1774398017;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=leWzlXRjKUHn6Crlsk5+VQIAi7Gp+SzgyV5eBtNfjVU=;
        b=L2lAUQXCMbutRlwTqsPz85ykXlVKv5phcQ0tp5PEiOkKdu3RHGdwUNoTeDj3P4OLnn
         m6wVGZk39T535JwZOMqLten0EBBqH445RMK/DQu77d/Hbd4paXqwLhbW1NudYhZKpcmg
         ijE6goivU3UjlIce81hk+Gk1fxathuapfWoK17kWQOrRnL2wWMNpNJi7tX1UTDzfDjbB
         VTwg7FXHtW1ce75zaqlcIEdBVJ/JIIEglp0rXwEvy+KjR14bW3o+oGNMiN5nQLDOTOyz
         0Mm1ePJHnwl0pm2YeFhc/CziZ2h5qvACpht0ymjiqt9WS+dtKkZIUm2LqB6+bzd3uz6w
         GwFw==
X-Forwarded-Encrypted: i=1; AJvYcCXslc2wsZwBvjxzFeKMQCa3gZaz9PNs8xkwWE8TqrPzqyN/ZUolJKf5UmBiOYAXkFseSfYBib9yd4po48I/@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGKI1+BjxQ2uO12dVyn9or9rFYJxmttV4US+ueQanIZW3FCMY
	OuyoC1LrA1+TIRGJ73LltZcLhBtkcobCz9XBC18ugw492OAyYanCwTN2XvCXBWtheMbqAvRySch
	As7OhaV8=
X-Gm-Gg: ATEYQzwslJ+r+Xeuo+VDHWV3B5P1PckH/aTNvjfLGsHgbyY+wl1kJXVB1JOzlJJwT9Q
	/8CFQ91AqZ1Lyh3UFK6ArBoz3w6F5wqIJXvAkgjirVcNr9oXgrxmgXvCE41TLeO8bjeSnjDRuh8
	SWqn5Ye8fMtWoLiDacTJtgxJIDDQkfq6DJTfRlU7aDRR0dgR0WfsZ5y6EaXXWEYw6C2IycjnKjM
	aWxKRWuOWOrxEND3OK1z+isXK5h4YLVBZmwKsy8Qbj5v1/TfPDlbBmrFgy+Rrx9SMln7kNCCvW2
	3jUit6JfLL9XsLjzyPsWRzg/nvYQA7oESx0e3vf/1/WtTDlIwDe3kJfc318ht3bjAJy+1Y2XV+z
	LH/OkRNnu1Dp2QNTEvYNDNP+G4BsuvOR/V+j7cDV+/WaRTLTnPpa4QptuAEvR16mjbtLgrnT87m
	9o4OEY2I1G2m135lsXeahcKVpTaoqvlLy69qdPtEbBIBNEnN79PLGLnWNhNa5nMrPMdXpTvUCBo
	5PS
X-Received: by 2002:a05:6a00:e19:b0:7b8:acdd:23c3 with SMTP id d2e1a72fcca58-82a5603b41emr3849369b3a.11.1773793217338;
        Tue, 17 Mar 2026 17:20:17 -0700 (PDT)
Received: from smtpclient.apple (S0106a0ff70715ac6.ek.shawcable.net. [174.0.84.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b598f91sm619872b3a.25.2026.03.17.17.20.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2026 17:20:16 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH 1/3] ext4: split __ext4_add_entry() out of
 ext4_add_entry()
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260317224638.3809014-2-neilb@ownmail.net>
Date: Tue, 17 Mar 2026 18:20:05 -0600
Cc: Theodore Ts'o <tytso@mit.edu>,
 Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0C7B39C6-CD1D-4A05-8418-68CEEE6C97B2@dilger.ca>
References: <20260317224638.3809014-1-neilb@ownmail.net>
 <20260317224638.3809014-2-neilb@ownmail.net>
To: NeilBrown <neil@brown.name>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Mar 17, 2026, at 16:39, NeilBrown <neilb@ownmail.net> wrote:
>=20
> From: NeilBrown <neil@brown.name>
>=20
> __ext4_add_entry() is not given a dentry - just inodes and name.
> This will help the next patch which simplifies __ex4_link().
>=20
> Signed-off-by: NeilBrown <neil@brown.name>

Reviewed-by: Andreas Dilger <adilger@dilger.ca =
<mailto:adilger@dilger.ca>>

> ---
> fs/ext4/namei.c | 21 ++++++++++++++-------
> 1 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index c4b5e252af0e..768036a109d7 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2353,10 +2353,10 @@ static int make_indexed_dir(handle_t *handle, =
struct ext4_filename *fname,
>  * may not sleep between calling this and putting something into
>  * the entry, as someone else might have used it while you slept.
>  */
> -static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
> +static int __ext4_add_entry(handle_t *handle, struct inode *dir,
> +  const struct qstr *d_name,
>  struct inode *inode)
> {
> - struct inode *dir =3D d_inode(dentry->d_parent);
> struct buffer_head *bh =3D NULL;
> struct ext4_dir_entry_2 *de;
> struct super_block *sb;
> @@ -2373,13 +2373,10 @@ static int ext4_add_entry(handle_t *handle, =
struct dentry *dentry,
> sb =3D dir->i_sb;
> blocksize =3D sb->s_blocksize;
>=20
> - if (fscrypt_is_nokey_name(dentry))
> - return -ENOKEY;
> -
> - if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
> + if (!generic_ci_validate_strict_name(dir, d_name))
> return -EINVAL;
>=20
> - retval =3D ext4_fname_setup_filename(dir, &dentry->d_name, 0, =
&fname);
> + retval =3D ext4_fname_setup_filename(dir, d_name, 0, &fname);
> if (retval)
> return retval;
>=20
> @@ -2460,6 +2457,16 @@ static int ext4_add_entry(handle_t *handle, =
struct dentry *dentry,
> return retval;
> }
>=20
> +static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
> +  struct inode *inode)
> +{
> + struct inode *dir =3D d_inode(dentry->d_parent);
> +
> + if (fscrypt_is_nokey_name(dentry))
> + return -ENOKEY;
> + return __ext4_add_entry(handle, dir, &dentry->d_name, inode);
> +}
> +
> /*
>  * Returns 0 for success, or a negative error value
>  */
> --=20
> 2.50.0.107.gf914562f5916.dirty
>=20

