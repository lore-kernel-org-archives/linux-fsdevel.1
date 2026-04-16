Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3130EF9B
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776377782; cv=none; b=TXvDrlBI2HPXWKPOuHe1J/5b9OBfO026JJu2JEoMnx7P9p7RRqXyItY2nPX9a4P0UaFFTW7RMHjRRheRsyj8+7nnSiR8imjERorEUk3Ju4P2UJEf+B/+p56F4f4xXDUND4VKDHK8UxD9xTA4+eZJz1hKwMYEHcdbAqVqftVQTjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776377782; c=relaxed/simple;
	bh=oPRDhwr/hOJvxg944xYcrkhTvL+eLFkPvhYmJB+XV0E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IOTuDoeiZcmi2chPf225flpElISx2i3W6WScT01w1CdDsT6L0ZoEZAJ6aHfc5S7A9eCsjih+map1/9z1BmzmXsHWKYzMGHXbf14qk8EJb5YiAsbyx8JDB/la2ZjfUCc/uAYRGF/TmzTd1YVK4a3Lw0pSbdsvRUGEFtnRbWnWnwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqnQ/oyC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q9zPsta9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqnQ/oyC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q9zPsta9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776377779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg1Yde900dZnvA1zX8a1F5Y9dfGeYPsrAapj+wpUhx4=;
	b=SqnQ/oyCoCVcroy6KY0ymYpDdM4DYhcSK5OED3WItvEf77SWUm7+lTFeMZR5V6jGYwqZ1j
	LDkYtfxUTk9M/1KySu4R7pdV23Sc0QWZUFCOfAhCiMmM85/rJtXutwQbfJd0nQ2OFLYNWP
	apGIOOkFvR2M6zB/7ZtZoFHne8HUZuI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-O7jC_zTmNVekoBX7qdfwJQ-1; Thu, 16 Apr 2026 18:16:18 -0400
X-MC-Unique: O7jC_zTmNVekoBX7qdfwJQ-1
X-Mimecast-MFC-AGG-ID: O7jC_zTmNVekoBX7qdfwJQ_1776377778
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-798656130b0so402327b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776377778; x=1776982578; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rg1Yde900dZnvA1zX8a1F5Y9dfGeYPsrAapj+wpUhx4=;
        b=q9zPsta9/2y44CckUtKyNRrEbf6KGE8nOTXlOn5hrsHz2x1j8woEKlWvAvgWhCh1/J
         UmZqd+wVdrpHAyEJMspJaGLKEVvERZyKEFoUOhWjmj0I5+RyYrqvvQyzroD7oYyqb3NE
         Kzes3DpW0YgYX27zCdzsAJNARoFtO5uuIXhCV7DZQrL93i7BhXWHNXhPqC97Nk9CqVJL
         oPn5w3z4FSBLpUl6UX857R0rMDwqY+EOkmWIy0HkpmDiVniUiGEEAQSvk0G4CxKlK/fs
         MrfKaxajj+ywb3PzAoiFSjUdzPdmx+5r8Uw7UJIpzKqyChyxiDyisOB6n9TBzZB3muzD
         MKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776377778; x=1776982578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg1Yde900dZnvA1zX8a1F5Y9dfGeYPsrAapj+wpUhx4=;
        b=rw42au4XKKyn1TsZmEYAP8sHcZy34Pj2RZNHWVuqWIFp93z2ZLqH4X+6S/1U9a+8mK
         ZERloU4oRiehXoAO15qWimGTtdNVwfUG8vC1d7cO1IFArMBk6r7a0plikefnsRJpxVNl
         IFopXsH+FH7g8+N+16feEtk/ER2r9YRazxC4FT5T+FNXsSaqdjIFY3Lip4oyfq1GAeGS
         LHMhNXP++daAdqD47ZADXl9kavsZZkN6FgQz4+430bKBE1lw0VWEBXdcfh8R6XN7H39V
         5sdP6rFGIQ3cttTGmIIkOV9U1E/gcyZlB8tiHxR3qSGU9gICc+a2+/YhvihApml0oSCi
         mOXA==
X-Forwarded-Encrypted: i=1; AFNElJ+9ZN9zKwew6lFGXviylO2Y1+flzHiBx+r2wqZ3xqXgmo+cfQ5f6piwJuOrDqrtxpvi0iGw+jZ/gK7Eqbu8@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYKpdlavQs/VvxaDm0qGYhw3TXYwon7X+Ob+KrrxIoX2n7FFQ
	c/Ac3YCRX4/XPvurpEe91hlWhEqFoEsDCvrK3mIVnX4OdsE/6aC6uUJoAUQOzRkTVNyb7h2ROPc
	coVhl00lwo3J9Es9gL8jZIpPmJ8ks3JPwL+xpSzIh1IPF1BbUQyFTp5rzPKVYddl9W4E=
X-Gm-Gg: AeBDiet4pLeS5JJUWDfSonpGCzYCqBoN2/Mgz03u5pS7yEIf0qnB4rumPMWAN3SBpsz
	pICL/iKeZiXg5tv9HDhZiJGQpnyMs8Fxwomexv5sBIfyU5HE0FS8xrJgAhCN7oGiXLVRyAYenEo
	YL3DqtUXFMZcsBNJmXMgFGFcUMGbIKSfogPhaAjfk3rF9gf6g9Pi2ulxOSgEC+2kw3gRZ2qaEZn
	XYtMvQkQ+EY+94DeNoSIV+gbNfv1EWYcL1DMgF1jWqNChhYLG3OqfEkOB4jf94oWNskSdriQU+7
	TKDE68POa3/DGwDRNxC5L5NuOwcUto05DwJByNkueYgCjDRjvo608GVS/nv6pNUz/eyf9nUbaZU
	F5Ypsrq/Knnphtqtq5jVGRY117RwTibRd1vTX+V5CuK04xsBeOAPED+G+JwHLbqw=
X-Received: by 2002:a05:690c:dc7:b0:7aa:451d:bf9f with SMTP id 00721157ae682-7b9ece752ffmr4550177b3.5.1776377777819;
        Thu, 16 Apr 2026 15:16:17 -0700 (PDT)
X-Received: by 2002:a05:690c:dc7:b0:7aa:451d:bf9f with SMTP id 00721157ae682-7b9ece752ffmr4549707b3.5.1776377777448;
        Thu, 16 Apr 2026 15:16:17 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b76621582fsm30771377b3.6.2026.04.16.15.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 15:16:16 -0700 (PDT)
Message-ID: <691e1d088f6461ac639716951274ede51e6f6520.camel@redhat.com>
Subject: Re: [PATCH v2] hfsplus: Add a sanity check for btree node size
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 slava@dubeyko.com, 	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Date: Thu, 16 Apr 2026 15:16:15 -0700
In-Reply-To: <tencent_616EF42CB16F489418E932EFEACCB479460A@qq.com>
References: <tencent_8ECE3364C36FE975C3A64444176177734605@qq.com>
	 <tencent_616EF42CB16F489418E932EFEACCB479460A@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-16 at 17:53 +0800, Edward Adam Davis wrote:
> Syzbot reported an uninit-value bug in [1] with a corrupted HFS+ image,
> during the file system mounting process, specifically while loading the
> catalog, a corrupted node_size value of 1 caused the rec_off argument
> passed to hfs_bnode_read_u16() (within hfs_bnode_find()) to be excessivel=
y
> large. Consequently, the function failed to return a valid value to
> initialize the off variable, triggering the bug [1].
>=20
> Every node starts from BTree node descriptor: struct hfs_bnode_desc.
> So, the size of node cannot be lesser than that. However, technical
> specification declares that: "The node size (which is expressed in bytes)
> must be power of two, from 512 through 32,768, inclusive." Add a check
> for btree node size base on technical specification.
>=20
> [1]
> BUG: KMSAN: uninit-value in hfsplus_bnode_find+0x141c/0x1600 fs/hfsplus/b=
node.c:584
>  hfsplus_bnode_find+0x141c/0x1600 fs/hfsplus/bnode.c:584
>  hfsplus_btree_open+0x169a/0x1e40 fs/hfsplus/btree.c:382
>  hfsplus_fill_super+0x111f/0x2770 fs/hfsplus/super.c:553
>  get_tree_bdev_flags+0x6e6/0x920 fs/super.c:1694
>  get_tree_bdev+0x38/0x50 fs/super.c:1717
>  hfsplus_get_tree+0x35/0x40 fs/hfsplus/super.c:709
>  vfs_get_tree+0xb3/0x5d0 fs/super.c:1754
>  fc_mount fs/namespace.c:1193 [inline]
>=20
> Fixes: 8ad2c6a36ac4 ("hfsplus: validate b-tree node 0 bitmap at mount tim=
e")
> Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D217eb327242d08197efb
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> v1 -> v2: change check base on technical specification
>=20
>  fs/hfsplus/btree.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 761c74ccd653..857705c3fe0d 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -365,6 +365,8 @@ struct hfs_btree *hfs_btree_open(struct super_block *=
sb, u32 id)
>  	}
> =20
>  	size =3D tree->node_size;
> +	if (size < sb->s_blocksize || size > HFSPLUS_NODE_MXSZ)

Technically speaking, you are right that b-tree node size should be aligned=
 on
logical block size. However, I am not sure that mkfs.hfsplus restricts the
creation of volume with b-tree's node size smaller than logical block size =
but
still in the required range of sizes.

Maybe, we need to declare the constant of HFSPLUS_NODE_MINSZ (512) and to c=
heck
this constant instead of logical block size. What do you think?

Thanks,
Slava.=20

> +		goto fail_page;
>  	if (!is_power_of_2(size))
>  		goto fail_page;
>  	if (!tree->node_count)

