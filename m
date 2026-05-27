Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33793E9284
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873437; cv=none; b=nldWF25nMyg1+//1kkFT4H2DC372POVy3JmQejBz+2vEyTshlSCfR+LKVkDUK3HuRbeckEP7eul90ryMH2AdYQkTwbKJ9eT7UwAVY+nfGG/q/dlgh0rRUGRbP9geeOfwgfHkUwZvFBkHxtIzzrm9ZUN21YM5BRGDo3+uiCODvnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873437; c=relaxed/simple;
	bh=IzVN5xW3kRQPCGsT55G3BnVXpO7OygZtxZk8spmtN0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGan14fqgCbJSGSVK2Eg8c6DlIvflVwLP0Ps2lsSQ3aqknM386Lb2ev/Rd8A4+XRl9YCAHVF2jzAo0BbfsrN0j/zCdN4O0EN84sL9350PY6J8HLNZh0q/GtfPHpxCKdZGSXhoxIPcEsr6S4zYRCW6VyTC9p3Ps/fHzZ//06OhCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqfwKguJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqfwKguJ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49040362e4aso59064855e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779873434; x=1780478234; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dHrSvc1jo9bXxcTvImuqQhfOCzHHna0fH4j3s8pZNK4=;
        b=RqfwKguJWRCJVb8ZJIhigcATVch/Ible+MepmJ2bYVamEzBw0jAL8dm7D4NLgwSWrO
         YNuGHqvSF1HlbKLjucIWLX40OOLqDN/1YGy/3puZDbUa1GFkbWEYXHIJAxd0yMnJzWzq
         EnpbgPOQi1p5p5sicGfBAADFacSihOFZ4AIi7PQEVqNvCDtISX2kWIMhJFbyZs2qRBde
         1XuD+xjft0CItGKMM/mAUmHe4e7g4m9n3lLUFc/S66B1j65jcAB5EFwh0IoXFrvk0FVt
         fzWC8FvP9PWi0Scwgi60DvVIvwH3hM2GaENYbbjc7vRrejelGH8rQpCasVZD+Xsxpzoy
         duxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779873434; x=1780478234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHrSvc1jo9bXxcTvImuqQhfOCzHHna0fH4j3s8pZNK4=;
        b=DZQfSALe3AL/hy1q47bOE1ETTK1DNv2aF/Z4pQMdZ16hiejGlbc9HZUxIqKe/f4glC
         DpPmBUiRoU79g3DjHd07YqXalCgnub7HWeqS/QOx2iMhaPcWgg5vUZwqlf/7cfNnk+wb
         sfdtPlDlOFlRmbTBYE1nYJUxq35iMjeRxtRy4MMlPtVp1NNLXydlLkaFIhojJ1SQ4zrw
         T44KlZsE0cnzvQKYzQFXq0zmeYnitwUY0VS1jSCG23s/b5Mw5iwqTst+8uzuCKTPlsHW
         S93LnrWT0Vn3EuH+rvi9IvOkkgPfteDOPSHU2qSfNSH0GHyhkv58LYVXqae26u4VWprE
         NRcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pLcID3ahwIgJLA5vtBOg/ziwBRTtqJz2Jdtxl8JgISPHOFj8gkOHphVyuUWwl/626QdIV7SUADohG+kvW@vger.kernel.org
X-Gm-Message-State: AOJu0YyBX7RpR4+Tsv5BdgEvhYPLBbyROokjcbbA+7IRHdYhU/0QHpj0
	z9c3Jym0Hdkj0GsPSD2L2D2+Fvcc1lXM53G2IUMCRdeSLpN9PKLYyfPo
X-Gm-Gg: Acq92OGWTK+BieLnaW4TFJQ0fNBknfeJlOlzNu1eilbcE6zVdh0iEVxKO3pUbjC1/Ru
	5Y8awgipsJb0Md1HHLydNxH8/XjModX2pmSibAw42wOPeMwdDsrybLrL3NT8fNKwFH6FmmSrgtl
	FgTF3z8KaNmFRsbZfCbsztlVwfB2BD9NaUU78Jr9iqd8I3IASDYT2yY3W/5dPkxS3ePba0v4mRW
	HCSOZItqymct/5a9+3vhD2CYhELvHlMEo7zMzx0UrPlGGQ+4PJqm4oZTU+3q/li6vMSDxkoh2co
	UyRR95VZ68diOluucAPQwgyBLDJnr8gcBfeNY/HSKIGUhiOhVHVyeOo3GPTpbCCGcIt4j6f2w/+
	r/TVSxNKBkgdsfk+q/0l9eorgAtGpCZWK16QhT9yv8UOJ7YpScFVsCnB2o1zE5PcwekSF9vLVcs
	y7G8rC8esda40sZtTaBiucDROcLw7EoPhOwaJgHw3fuDoOMSC1XO+/Jhaiu6JIgRcE5tJzEvI=
X-Received: by 2002:a05:600c:6094:b0:490:625e:bb68 with SMTP id 5b1f17b1804b1-490625ebc14mr214506055e9.3.1779873433852;
        Wed, 27 May 2026 02:17:13 -0700 (PDT)
Received: from f (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b1a28sm4666944f8f.26.2026.05.27.02.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:17:13 -0700 (PDT)
Date: Wed, 27 May 2026 11:17:05 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: fffsqian@163.com
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: Re: [PATCH v1] fs: fix spelling mistakes in comment
Message-ID: <22tr2m4v4b7kc5w7eoclxdcajodtvfl6e2jvgvx4vd7k7atvdt@l4hxanuf5squ>
References: <20260527031508.820423-1-fffsqian@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527031508.820423-1-fffsqian@163.com>

On Wed, May 27, 2026 at 11:15:08AM +0800, fffsqian@163.com wrote:
> From: Qingshuang Fu <fuqingshuang@kylinos.cn>
> 
> Fix three spelling errors in the comment for an internal file structure
> allocation function:
> - happend  →  happened
> - over     →  exceed (grammatical fix)
> - int      →  in
> 
> Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
> ---
>  fs/file_table.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 16e52e7fc2ac..fa06b660f116 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -231,13 +231,13 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
>  }
>  
>  /* Find an unused file structure and return a pointer to it.
> - * Returns an error pointer if some error happend e.g. we over file
> + * Returns an error pointer if some error happened e.g. we exceed the file
>   * structures limit, run out of memory or operation is not permitted.
>   *
>   * Be very careful using this.  You are responsible for
>   * getting write access to any mount that you might assign
>   * to this filp, if it is opened for write.  If this is not
> - * done, you will imbalance int the mount's writer count
> + * done, you will imbalance in the mount's writer count
>   * and a warning at __fput() time.
>   */
>  struct file *alloc_empty_file(int flags, const struct cred *cred)

If one is to touch this comment block it would be best to sort it out
overall. Or better yet, not just this one but the entirety of the file.

For starters there is a format to follow to document args & return
values, see file_init_path for an example.

That aside even if your changes the comment is definitely wrong from
grammar standpoint, but I don't know English well enough to be confident
I would write a fully correct version.

"e.g." requires a comma ("e.g.,")

That aside "you will imbalance in the mount's writer count" reads way
off to me.

Perhaps this is best left to native speakers.
