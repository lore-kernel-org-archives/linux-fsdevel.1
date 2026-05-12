Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F249550B
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574911; cv=pass; b=kux2XpBalxqEzWz0xK9I4CSIfF6hSgkHGGtwCjzFXjow+ZJ56ue0lBgwOwG8ahs2GC0Enyg+tha7qFeJf4OJWO+CrqTCuMKEXHlG6PKwDE54Ebbv0i/uHrgN5JlkGuHP1MIXaHU/LnWL0/xrQdfTH7CifC3unRLfX4K/DvXr2Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574911; c=relaxed/simple;
	bh=/3s0/mDXbWzhJFL7MoH4SOEmubiVDCgZVTWlu9ZhNXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENjk6+DnYmgd1/+VDwD2EPMpQcby8JYZgT+8tIyXAC4ARKGZDfbX6dL44mXDZR183kxDxQrwNbA1VfmYHIjMslsR12tIFvsjSQpuHm8+/OoskhJAvhHhtTP+RfuBWhtP59rrdbzS7aUUeCUr3UAyPSWy7cQnXi9tfDPsaBRuIKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WbWW7KnJ; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WbWW7KnJ"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-514ae601e01so24676961cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 01:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778574909; cv=none;
        d=google.com; s=arc-20240605;
        b=lK7OU/EAhDABNAxXpee1RqjScOU53Gim2fvhANBedzGNlSHcMyStawribObufl5pK3
         0v5JLU+xXANyE5Uw98g2Vb2EmlwmZRTvlH5QYyY1CvDfs9tymqjI2F7otMZmVEvnmM4/
         1FvqYyxKGjtlWQd2eSi3CzMZNzv0U3jxGgG8cMoNiqXLF+y2lOKdjGcWzkc7WwV3tkZO
         ZM2kf7s8BdgIwTwuuQ6g6oqEUTKNFAPeI0mjmt0oJgLJCkdVTb1WIFcwdB8V4AcLGsMW
         WNyjmNPSMKNJRjNPdYOtcko6P0j9QpPeEarGl8Sdany66LhGIzb23HVEPO/GVQNQ3p3k
         Qvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Q04gWJ+CUF2CAh1IlYHnpweBjQkfKkODdF6dN1ETVic=;
        fh=1Cw2l4VmG/Grd5K5uBjh0uIj4lr1xb9ytG04b4ltQvk=;
        b=PYKo160XEP4gU+EgXc+SbvoIUZ5uy+hm3X3k5NQLHrdRjsNLIuJ2rUlbAqKSc6WBTk
         LQ6RMEyjLvQ7gpVYQ0QMHggoKdYfC9xitADfUnK7nH99/TsQy+Vb0NfCCkAoRfD71bO2
         gXUYAmlVM1hHJDl0EF0Wtt7SVPeUX60kxRSTD7QwS0e5XwhI7WahV6fXp6irVJNDbA0v
         W64U53bUhiMMwhoHbTZnYuPwOhGWXL10JY6nCbNwGDHM5xZcjf8iFW0KxSXNWEobfqSV
         G+VKOiz068knZ6YYdDrJW12qreZqt7Pqx1RIzNNwXmTQlaGvbAbX4WU3kr+wq89EBvDm
         YcnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1778574909; x=1779179709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q04gWJ+CUF2CAh1IlYHnpweBjQkfKkODdF6dN1ETVic=;
        b=WbWW7KnJljdJFXKfuW7nG2BYjgeF2NGEbGnBL6Vl70XlCcCA+vqS6AOetgtvB3F6JJ
         i4wkU1sFINJoP1Yf5egCPsARsK8IPYLG/+2J6W6jaXBZPFXDpV+hQgn/HGPUqCUaOGyE
         tddRMrm+H7p6HSA504sR9jBCz5vofe1Fttmqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574909; x=1779179709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q04gWJ+CUF2CAh1IlYHnpweBjQkfKkODdF6dN1ETVic=;
        b=J4IS54ck58VD8FJ8nBzDzRIb2VfCWYmct0xHh4oO8MEHdtSd+utzTdBDTEe56MBWNX
         7rPv8jr4v+Z/0v+5FKAAUA55Et8g56HTAZw1qQR8KGsHRPgIHEDcLmc8BrQltpbYbY1q
         jjcOaEMm3C0L8wBSwNS6Bga2/F1iMu3lXCpeZvlzBLkqKRyouhMmnxh5RTp/6TK6uwcQ
         cGCcAyQLHOBbOvpRpaTxGl+Tn2BWA8AXPXoWLKVAZ6W0DgUwGqNXPtix/dZSM9m2UYhh
         92jLAtUj5iLt4hqdefb/qi93fDPD/1u2wDtHWTNRL9JhAIYxrVklyNICEr86ITpUUhCr
         K4xA==
X-Forwarded-Encrypted: i=1; AFNElJ8ATyWINiRAJC/yyGhGqaTaY2cXHYJFnTzsg/OE5uE9qifvmKLoYibJ55pGqcH4Z9PWmvOobKUvE4QLgeuL@vger.kernel.org
X-Gm-Message-State: AOJu0YzKLF3cN70o1nYJWaGHKpxucWIv9yqbMzi9JuUnsP/vUe1PPbZp
	Rzo4qAhB63wMcfW5+U5Jusrx32VE1UvLoMzPFid6iOfFt17/ZnD4iPuldtHkPR9T6PxeY2T7NXd
	ZlgOJ4U5km8xfTf942DnE3iJw89zmkIFYJK3eTOqfxQ==
X-Gm-Gg: Acq92OHbXHLgAKgluJiJVFR55VEt0WpHFL2eeb661xyhPsryoJl1zEjJU4Au1hbbMeD
	QHYgOJT2Ia9hBdHE4Ov1qd2v1bgDiPPEBcvf1Q5ZElSn3jpRNnF9SAhvzeH1U3uMA6Va/UZ1Uag
	Y9SdJUsRpTi3/JFdh6utsIUBT/GKhibJ7YdHXN8+olR1PM7t93EOBbigS+IjYuBq2oSKejhAO5N
	kvUyR8me2elsgjQZ3GsPsMquJQINYRhvMtddeNIDBEPa19ip8yFPgVpmkxntMeYYZMYVErUUnfI
	QUamVeUKobxZjkkE996r9K4+sPF7+GfqbzSQbcM=
X-Received: by 2002:a05:622a:4ce:b0:50e:ca38:e219 with SMTP id
 d75a77b69052e-51461fb1949mr384399651cf.45.1778574909069; Tue, 12 May 2026
 01:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <agGW6FCbnIyy_OuE@fedora.fritz.box>
In-Reply-To: <agGW6FCbnIyy_OuE@fedora.fritz.box>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 May 2026 10:34:58 +0200
X-Gm-Features: AVHnY4IGzwKh8cpEe6DCcQkdz6K7ue3d7clb57ySdTj79DPpRlJJjVaw0ngtEjI
Message-ID: <CAJfpeguYt4zgkTsM6nAvUSxqSZQm18DZpMcJZNWuCiSmV=BGJg@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a9f38306519abd8e"

--000000000000a9f38306519abd8e
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 11:04, Horst Birthelmer <horst@birthelmer.de> wrote:
> @@ -1337,6 +1338,7 @@ static int fusex_send_opendir(struct fuse_file *ff, struct inode *inode)
>         if (!err) {
>                 ff->fh = outarg.fh;
>                 ff->open_flags = FOPEN_CACHE_DIR;
> +               ff->nodeid = get_node_id(inode);

How about this (untested):

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3bdab8d03373..1b5a262147ef 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -594,7 +594,7 @@ void fuse_read_args_fill(struct fuse_io_args *ia,
struct file *file, loff_t pos,
        ia->read.in.size = count;
        ia->read.in.flags = file->f_flags;
        args->opcode = opcode;
-       args->nodeid = ff->nodeid;
+       args->nodeid = get_node_id(file_inode(file));
        args->in_numargs = 1;
        args->in_args[0].size = sizeof(ia->read.in);
        args->in_args[0].value = &ia->read.in;
diff --git a/fs/fuse/fusex.c b/fs/fuse/fusex.c
index c4bc03e57ed7..43c03d7f73ab 100644
--- a/fs/fuse/fusex.c
+++ b/fs/fuse/fusex.c
@@ -1379,6 +1380,7 @@ static int fusex_dir_release(struct inode
*inode, struct file *file)
        ra->inarg.fh = ff->fh;

        ra->args.opcode = FUSE_RELEASEDIR;
+       ra->args.nodeid = get_node_id(inode);
        ra->args.force = true;
        ra->args.nocreds = true;
        ra->args.end = fusex_release_end;

Thanks,
Miklos

--000000000000a9f38306519abd8e
Content-Type: text/x-patch; charset="US-ASCII"; name="fusex-readdir-nodeid.patch"
Content-Disposition: attachment; filename="fusex-readdir-nodeid.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mp2dk0gq0>
X-Attachment-Id: f_mp2dk0gq0

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZmlsZS5jIGIvZnMvZnVzZS9maWxlLmMKaW5kZXggM2JkYWI4
ZDAzMzczLi4xYjVhMjYyMTQ3ZWYgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZmlsZS5jCisrKyBiL2Zz
L2Z1c2UvZmlsZS5jCkBAIC01OTQsNyArNTk0LDcgQEAgdm9pZCBmdXNlX3JlYWRfYXJnc19maWxs
KHN0cnVjdCBmdXNlX2lvX2FyZ3MgKmlhLCBzdHJ1Y3QgZmlsZSAqZmlsZSwgbG9mZl90IHBvcywK
ICAgICAgICBpYS0+cmVhZC5pbi5zaXplID0gY291bnQ7CiAgICAgICAgaWEtPnJlYWQuaW4uZmxh
Z3MgPSBmaWxlLT5mX2ZsYWdzOwogICAgICAgIGFyZ3MtPm9wY29kZSA9IG9wY29kZTsKLSAgICAg
ICBhcmdzLT5ub2RlaWQgPSBmZi0+bm9kZWlkOworICAgICAgIGFyZ3MtPm5vZGVpZCA9IGdldF9u
b2RlX2lkKGZpbGVfaW5vZGUoZmlsZSkpOwogICAgICAgIGFyZ3MtPmluX251bWFyZ3MgPSAxOwog
ICAgICAgIGFyZ3MtPmluX2FyZ3NbMF0uc2l6ZSA9IHNpemVvZihpYS0+cmVhZC5pbik7CiAgICAg
ICAgYXJncy0+aW5fYXJnc1swXS52YWx1ZSA9ICZpYS0+cmVhZC5pbjsKZGlmZiAtLWdpdCBhL2Zz
L2Z1c2UvZnVzZXguYyBiL2ZzL2Z1c2UvZnVzZXguYwppbmRleCBjNGJjMDNlNTdlZDcuLjQzYzAz
ZDdmNzNhYiAxMDA2NDQKLS0tIGEvZnMvZnVzZS9mdXNleC5jCisrKyBiL2ZzL2Z1c2UvZnVzZXgu
YwpAQCAtMTM3OSw2ICsxMzgwLDcgQEAgc3RhdGljIGludCBmdXNleF9kaXJfcmVsZWFzZShzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKICAgICAgICByYS0+aW5hcmcuZmgg
PSBmZi0+Zmg7CiAKICAgICAgICByYS0+YXJncy5vcGNvZGUgPSBGVVNFX1JFTEVBU0VESVI7Cisg
ICAgICAgcmEtPmFyZ3Mubm9kZWlkID0gZ2V0X25vZGVfaWQoaW5vZGUpOwogICAgICAgIHJhLT5h
cmdzLmZvcmNlID0gdHJ1ZTsKICAgICAgICByYS0+YXJncy5ub2NyZWRzID0gdHJ1ZTsKICAgICAg
ICByYS0+YXJncy5lbmQgPSBmdXNleF9yZWxlYXNlX2VuZDsK
--000000000000a9f38306519abd8e--
