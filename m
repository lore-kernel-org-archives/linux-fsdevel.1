Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F8329E47
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779077882; cv=none; b=aGPjfgSIH5r+BWwfTtI5+Pe6erSeBun4UTvXuQaQYZE4Ofty6u7KBRydaJXxsy6BGgtnQEQwX22x9flxtXN/mQBFCD4U0E6V1ljuRDCOw0+bOnI8eoVLIuFbRPR3lhec49ww2TVEGJ+MkppIrpxeKXJKWWWF1vp4YPI4FHV9pas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779077882; c=relaxed/simple;
	bh=YG/BgdoXkMU7wOLT2RlqsHhlNFanAphEsQz/NJdB0fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fESDYgsoE8tcT+teP0oBceMbWLKj9d/54ZWBuJ205bqGpz3GTthvfwGzx75NA9YMWKLHkiqkVrjrwnS0ShnOhwl+lM53DlHTqMVnAo47niihuJM4yLODGyENQ1/KMRsZZVJ8VYGxdHPGPFcnkPOv6Dm45TGB2kSVz2Ro4BmYR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+vA5QRT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+vA5QRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D30C4AF09
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 04:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779077881;
	bh=YG/BgdoXkMU7wOLT2RlqsHhlNFanAphEsQz/NJdB0fg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D+vA5QRTwPDJhHLJmrSCp5E61i3HNDAp0ZDwoATV0QEvFtJ/KHWOEY2yz/oJXlstP
	 hBAPRkfVmrI6q321zGcyW5f86ulhBXUqG5iFNUY+8Ke2TlXstGCe2LXk1S0oGKKczr
	 GNlYCph0xDGpZ05lr95+Y42d2yCnW+PWvXvGUPmbSlWsgO48NzFtAngAXSU5y3Tk96
	 LBwbK0YxEGraDS4tosheN+c4eoce/vp4Hrqiz/FrSEAEvx2PX3gnowyFhdAC2ZK+LN
	 lS2wbt58WofzntI9T9SazzmDypDLzRj3q5/94aI/rQGbYwk59vAton281eZjDiMN7C
	 o9v836bUZfxeQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67fd8befac7so4764341a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 21:18:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YzCsqdSaKlEdCPEugMPoF9nRPaLGkojb4TOlHPWOgWYOTT4OUGD
	oBvp22wefW1X0MFEvsckQfjNbDGw550dtFOYGnDW4J48V3m9nXAoQnUN+rTex5hF7cuSOQ8Mje2
	66ZFxvcPoEwUPoQBmNTd/TfryrH37VH8=
X-Received: by 2002:a05:6402:234c:b0:66e:378d:2e56 with SMTP id
 4fb4d7f45d1cf-683bcc9b7b6mr6769430a12.6.1779077880577; Sun, 17 May 2026
 21:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYAXd8z00CwRgbQbU8U15svgyOT6RK4XH-xcaq7k3dBbsRqew@mail.gmail.com>
 <20260517184141.21939-1-rochan.avlur@skydio.com>
In-Reply-To: <20260517184141.21939-1-rochan.avlur@skydio.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 18 May 2026 13:17:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_PUKHpL4xtkcS+5iDGwf+WgEOFvM4T_XZ4SRtk8-jCyQ@mail.gmail.com>
X-Gm-Features: AVHnY4L6gQ-y9ftJPRqN6QxRoPb0acBpBa6BSZbvh8gZDdzEVhy8cFIFBojQhwI
Message-ID: <CAKYAXd_PUKHpL4xtkcS+5iDGwf+WgEOFvM4T_XZ4SRtk8-jCyQ@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: preserve benign secondary entries during rename
 and move
To: Rochan Avlur <rochan.avlur@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, 
	Rochan Avlur <rochan.avlur@skydio.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

> @@ -523,6 +523,20 @@ void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
>                 es->modified = true;
>  }
>
> +void exfat_remove_entries_nofree(struct exfat_entry_set_cache *es, int order)
Please merge them into a single function by adding a bool free_benign
parameter like this.

void exfat_remove_entries(struct inode *inode, struct
exfat_entry_set_cache *es, int order,
                                   bool free_benign)
...
            if (free_benign && (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC))
                           exfat_free_benign_secondary_clusters(inode, ep);
...

> +/*
> + * Copy benign secondary entries from @src_es to @dst_es, placing them after
> + * the new filename entries.  Updates num_ext and the directory checksum.
> + */
> +static int exfat_copy_trailing_entries(struct exfat_entry_set_cache *src_es,
> +               struct exfat_entry_set_cache *dst_es)
> +{
> +       struct exfat_dentry *ep;
> +       int extra = exfat_count_extra_entries(src_es);
> +       int new_entries = dst_es->num_entries - extra;
> +       int i, src_start = src_es->num_entries - extra;
> +
> +       if (extra == 0)
> +               return 0;
It is better to move the calculation of new_entries and src_start
after the extra == 0 early return.

> +       if (extra < 0 || new_entries < ES_IDX_FIRST_FILENAME ||
> +           src_start < ES_IDX_FIRST_FILENAME)
> +               return -EIO;
> +
> +       for (i = 0; i < extra; i++) {
> +               *exfat_get_dentry_cached(dst_es, new_entries + i) =
> +                       *exfat_get_dentry_cached(src_es, src_start + i);
> +       }
> +
> +       ep = exfat_get_dentry_cached(dst_es, ES_IDX_FILE);
> +       ep->dentry.file.num_ext += extra;
> +       exfat_update_dir_chksum(dst_es);
> +       return 0;
> +}

> @@ -1056,11 +1117,15 @@ static int exfat_rename_file(struct inode *parent_inode,
>
>                 exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
>
> +               ret = exfat_copy_trailing_entries(&old_es, &new_es);
> +               if (ret)
> +                       goto put_old_es;
> +
>                 ret = exfat_put_dentry_set(&new_es, sync);
>                 if (ret)
>                         goto put_old_es;
If exfat_put_dentry_set(&new_es) fails, It return without marking the
new extra entries as deleted. This can result in duplicate entries.
>
> -               exfat_remove_entries(parent_inode, &old_es, ES_IDX_FILE);
> +               exfat_remove_entries_nofree(&old_es, ES_IDX_FILE);
>                 ei->dir = dir;
>                 ei->entry = newentry;
Thanks for the patch!
