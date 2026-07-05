Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA7536403A
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jul 2026 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783295619; cv=pass; b=VRbWjFmeMiuw0ZAWFPgrQhX87Oy/GVnjMj8ptNbjDbMA5kNRtKXK4GZTkq05/Q7rXOkLIhLxt0zUGabTTaqxjae1Cj3EPnMC+FlilYkY0/Z1SX+4dG3ErXoWtB7ziWjzXhnd8XHYLayuBnfZ/GzQ7feVij7xF7OjGbPODNgEvJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783295619; c=relaxed/simple;
	bh=8zqCoHKFeC9uoz6U6aQKSJAwAQgmF7mbenzFeRzat10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbBEBIIfFnIM9qVDyBxRBc3ELL0e4Vsk3d/jXDYN1HsdcDrmeuSYU/XZxjbJMXb+x/J8rLPk5PqW2uydi0HaZ9qm5jx4T3+pWQMZ2eHOCCnwRnsVOLOSs685uHzCMHONmMY3RUA704oK2cexPF+QMpwYaUQJjO7EcyHf5i7LOrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVCwGSMT; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVCwGSMT"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aebf9a50b8so2441679e87.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2026 16:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783295615; cv=none;
        d=google.com; s=arc-20260327;
        b=BV6BfbooOh48WzHkSNQaMhQI/bwPvv4s8SdnfOSeDCGw0xjED0ieb2X0nXiktZ4Ogd
         REr6ZPnSCLqOtLlfqVuOMEd65bijC/Dx/D8O4I0XiZDQ/h20xyHPit3S8Jy+aFxtp9sh
         riXlQDSWmwRXF8TBJ3EMK68K1h6MdPRGrdghQxm1zEgIc4hU0TRbEo+9wxiWJA0zjF2v
         JeUX2w3vYp5E6aCEYz2rPsJUNQvR84GqtXuMvJV8BSh3j9NSANsg7OO789v/DFb5U8Wa
         a7ZQMLHexe0ejNzieG3prco17lXAFRjdrhZj8r7OSo6PVRF0zOno2JX3S5/1jJAK3ZCW
         tkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TTWw1o0EuThgWnzsFpwy1aimUMVGloN7lcc8yYZAv7Y=;
        fh=n3cLY1cOoSEeSxk0+fHygMkLfUMwAdg+UjMqxUEy8uo=;
        b=Z0ukz6cGOQqlhtEib2yGP5LpUNKsHHrA+ePjYCT8MtlglkUNKwTWvwqt7gVvIIpCax
         E3QjGf7Em7CsdfQDLSoWPo1M77VDgQKMC/2j2i0H6l4vg4kV66vHdqJymsfbhbFWsNaW
         HPzxQFnWb3UzBYA3FZTgWWFTQqS/n8upH0MdigzD2mb01EJEZx52HNL7/TLXs4lxFCMt
         68ozE6GZzXmuLql6xvNl2B/fVRIcaSsM7NOyx1TU3kvANHnz0CmcZOTLWvQwZ8NlE/yw
         u5WPIczxbKGdIwvrOTYcaI2WWQfKHuwvvnSGZ7qDue5RtUubldgjqwja4u+SIjM4HJeQ
         P8mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783295615; x=1783900415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTWw1o0EuThgWnzsFpwy1aimUMVGloN7lcc8yYZAv7Y=;
        b=DVCwGSMT/2TeiSgXl2WpnZdhtYIyGKX5lHdylJOWp+bXjdlo0UdMRMn5hKoU3CxGRV
         sSr3yZDdDH4DuwT42oD5NcYuiYr4DxwZrHcTvQJqTw4Q0qL//yhR6bypUhnhIgqi6VMO
         VPrmdZyTmurZGwBIV+jfhUVqwSCnFQVpiUKlRrga8FhZoms+Xgj/fSy8xrXZHfXl69m3
         qnslDeKLE18Kk/su1RLwzNw3pdEl5zmf9WsSleasQUbj4uYCkfpbOaG6JY6J8L6Ufqew
         9oirABhoXjZZNzlnwSL+okPmCSWHYybdYZm048R3VROci0y8F8I6/aRJuXAROgoM/pve
         dzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783295615; x=1783900415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TTWw1o0EuThgWnzsFpwy1aimUMVGloN7lcc8yYZAv7Y=;
        b=WjS9iV5ADyXn12tcGA40m6f60alNTDxNCUnikT8qFA24etAW4OTzLUevjzKUCQzDVM
         b29ytMKiPnlMIuTzRsyTVXKuSlFLltiBFIDa74pR6uea0c0q5d+tkYMYtFUTI2pGScNB
         pOITByrvzSwA369Vdzeh4+kum+VUa5s9O9oF7SUjgzgJY7zxDaSvgDWdK9cSwDY0WAUT
         V4g3Ga0mU7x61N29TmmQYITmh6iT4FMenzZbUcKzOUCC+JXT7pwTo5r3Y3H5aXwdmdan
         w+24Yb5uAyDHwYUt9vssB7VrzFi1WsXIr1gy0SP2NhrKedGD0YqT7Mnsh3iRVnXa3Uz/
         uX0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrKq0ZopZF67ie616D+gas8DkgN4QUv3BTFj3yajhu4v0IzyOM/t5o/mix+Yz8CDLUUcBlQ5ZSzBoEhiELo@vger.kernel.org
X-Gm-Message-State: AOJu0YxGq98AwPcZtn7H80vaqy8JtlVsVkFJn2Co07pyJt5Wr5VWxmid
	CTpyI9nn+D7kUl7C5NKXTmhLFE9TKIbiFEPKtmh7WGZrB/GlrvUL8/9HpMzbZ0sdafFY+2UdStr
	UxL4IkTVqL7WhCxo8XY5HZyDR2AWzW5hK9w==
X-Gm-Gg: AfdE7ckqJ7dF98RGdog5913unNj93ZciBpmd3jMUiahYq2nPMAt3iBgZNUs24hrgGb5
	I4Qptg99jVbPeRJ0tuxOllKTNpl703Z7T+8jyI0GMsJYWaLXPQmqq4FSxdhs0kOKkNf5c6sOv9b
	G8GCxeO4IPZ52Nm89MscJcuwLPikwxpI75acUWyiPAJGTWHVKC+Mbrnj3ko+q8DozZc0Hqdsiua
	pCN91kvsBA/f9bYFhNQouxcyWFypvOL2+61EZHduJqHl2iOO42i9XrjpHYiXZCXSppqcyRY
X-Received: by 2002:a05:6512:b84:b0:5ae:a9eb:c5c3 with SMTP id
 2adb3069b0e04-5aed50a6a58mr1605009e87.61.1783295614623; Sun, 05 Jul 2026
 16:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0B853B9F28048C99+20260703054528.2798189-1-peiyang_he@smail.nju.edu.cn>
In-Reply-To: <0B853B9F28048C99+20260703054528.2798189-1-peiyang_he@smail.nju.edu.cn>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 6 Jul 2026 08:53:23 +0900
X-Gm-Features: AVVi8CdhdpUar1OlK7-HXFR-uDvQpqXaVafcsI4eb6LynpHfQxh21iiOmWvg1ao
Message-ID: <CANFS6bbjC2=BrmsAdm4h-KW8DD3ou4+sfS9JmWjx31=56YXq5g@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fail attrlist updates when the superblock is inactive
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 3=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 2:46, Pe=
iyang He <peiyang_he@smail.nju.edu.cn>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> generic_shutdown_super() clears SB_ACTIVE before evicting cached inodes.
> If eviction selects the fake inode for a base inode's unnamed
> $ATTRIBUTE_LIST attribute, ntfs_evict_big_inode() drops the fake inode's
> reference on the base inode while the fake inode is still hashed and mark=
ed
> I_FREEING.
>
> That iput can synchronously write back the base inode. The writeback path
> may update mapping pairs and call ntfs_attrlist_update(), which
> unconditionally calls ntfs_attr_iget() for the same $ATTRIBUTE_LIST fake
> inode. VFS then finds the I_FREEING inode and waits for eviction to finis=
h,
> but the current task is still inside that eviction path, causing a
> self-deadlock in find_inode().
>
> Fix this by mirroring the teardown guard used by __ntfs_write_inode():
> once SB_ACTIVE has been cleared, do not try to iget the attribute-list fa=
ke inode.
> Return -EIO so teardown aborts the update instead of waiting on the inode=
 it is evicting.
>
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/AB8D5E603E6EA856+ae5f622a-dd3a-4e38-b=
dd2-42276ae0e1a8@smail.nju.edu.cn/
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>

Could you add some comments?
Other than that, it looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> Assisted-by: Codex:gpt-5.5
> ---
>  fs/ntfs/attrlist.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/ntfs/attrlist.c b/fs/ntfs/attrlist.c
> index afb13038ba42..1658cbe1fa59 100644
> --- a/fs/ntfs/attrlist.c
> +++ b/fs/ntfs/attrlist.c
> @@ -57,6 +57,9 @@ int ntfs_attrlist_update(struct ntfs_inode *base_ni)
>         struct ntfs_inode *attr_ni;
>         int err;
>
> +       if (!(VFS_I(base_ni)->i_sb->s_flags & SB_ACTIVE))
> +               return -EIO;
> +
>         attr_vi =3D ntfs_attr_iget(VFS_I(base_ni), AT_ATTRIBUTE_LIST, AT_=
UNNAMED, 0);
>         if (IS_ERR(attr_vi)) {
>                 err =3D PTR_ERR(attr_vi);
>
> base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
