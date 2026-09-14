Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E79343D8F
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789416729; cv=none; b=rlGngMcGhYOsKWJWDpCR1j1y3OLGwvHaZV/OJF5qPcHlGflwWHzAtzdYirDFzEF7WjhVB1YFS44qKruYYmMYGHpLo+GgHhw/S6q29xDEEpfCHhg6jM8jiySB7C1y0+iOe7XcXpzALly8FzJGWSf5wSHSJswE2Rs2YwMrIpjUimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789416729; c=relaxed/simple;
	bh=xZNf63J/YIRdgkjMJha77Ndz/TJo8Kyy5wkhd7RrUFw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VeDH0VTHjR3a5RKbL9WSUQlrt3NXPNx83Xm4cxdqD2SMQeyfUplQSF4ZIVbvHMjvDxR7usq4YK3R1GrbecZWN69zFIfMYZsI2aBnFDRw7UInvvBnROWJOSvEIU12Qo/5EbhRskyDLVciMRq9afThvxLOEly0+wozQHJpZxEPgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=irVtmJOb; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="irVtmJOb"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43da99ddso22712377b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789416725; x=1790021525; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0PjxwrCOziiYu8uSkEPm22c3tupxZ4SMu/g885xA93c=;
        b=irVtmJObt4MezZ/1/WePXXjhbd4D2pT96gHHXA99xzSCa359x830wUaZYrwCNgp/M2
         dn/3BVc9s7eckLg0/NlwUqyX1Wpd/c74O48vliR79IhmtaPO3lVR/F/pNl9crPs54Ivl
         8uJNBzkHsWJS0jRDI053xBhOtBQ9a48JCfZirFVFUfI3MW2EL+CqtkOODLOJ9OSH06nm
         AOmiB7lSo5N8du6zlty/uCVvV7oZWyJKBOUh3EGPK5zDg3qrvkBVX4Dmc4Kvz8yLS/cH
         RjN4+qLKcIRbpp34pTp0N7NWikf40wfb24jIaqeLU56d507m0RGqJfAbXsNPNab45mUR
         9EzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789416725; x=1790021525;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0PjxwrCOziiYu8uSkEPm22c3tupxZ4SMu/g885xA93c=;
        b=qyLs57rXkiEIA9oL9OnRwJ0CtGC7T+xcYL4Zgip1itdS0fJETqkferOeImgkC1sx7P
         y/dzURSOtnsRbZALYcY17Hixh1cf4c/pru/hIqUNeBQMI6WYDa7Xpdr84A9e6KrbsQ0q
         8S4cjaSA2TNSaQz+jmpyIAWCnfp/1l8aJPfTVfpmsL7SEMICTrosl6RnRVZUc9R2q+TF
         usutPP5horDbzXaDXedpSOEB0zmao+C94YDk4P/pJSysFqohJ9yllpMJmNgWjRfYDYYl
         Zae9ZmFmMjk2CW+wLwhkkT/cfACokfks+YIOxdcx2f/QTez7oVMBRRWNEjoAAveXPEN+
         U5GQ==
X-Forwarded-Encrypted: i=1; AKwUvByqB2yEOCP1k9FU50iSX3RjicfJjH6Z8beeDtD2R5rzZ/pxUTG7PK1u6vu6/3aPG6uIf9911ESQ2NvXEdPa@vger.kernel.org
X-Gm-Message-State: AFuF++nti6O6TQauAm9IFuO6O91EqjSEx+2orcgmVqVlXDtg8hcA7W2Q
	6o7aES5sAOD0QTLxk5wqGJc431rglqVLXn6Li931nkP1bdBxqy5aFsl3JZCdYjtvhFg=
X-Gm-Gg: AYBFou02XLqaXpgtYKllG1YawM5RSyQq7M91Wcq9+gq+J+lSESW7+XsJCWNncmoBP2x
	8XSbHedY9uR1wPNGFBS13GkxLffqV34gMomQIrkN4AMeX+DKCdYIUV4oRWBEo3iTUAayLusjxTq
	jsZwgCZV5Sc3KSi3a4LMU1rTEAMgTN4laq9mZmRRH1vlVYevY3q4jW0yXT/roce0q/bSooPX70N
	msXJ+xk7s18bUXqDzBR5IdHzV27F89LHlwD73nRirLO1jBDaYg6vK0tTkmErIVZutVM9z+yaW5d
	ELzyUv070wwiV6dn3ZFydOh0077fKb6L+1rdXbc5dOPY7LJ94nQQQXWrH+vG9xTUsYB7+DbhUz/
	89jiefn05PBsMywsPnx/cper2J54UG9F+s4nlL7EcgoxI1LEo4U8jXdsPQpaN67MYoK1TXnJGcS
	3vsE7I4LeJdiOjDHHc/prE6gi7W4q9AOqoItqR+c62r++FOQes/o4kiYo5PuNHYQ6PO6yfTLIaT
	8o8z28yghIAdeygbOZOr1XSnZm93Zjt/ySLYzGJ8rQhJtSLUzNFy/3CD/IZ9PbhM7us9IZd9Cff
	hNaMoZWeSvMcE4VLX0mlT3i+y7J/zLM1sJoTquM=
X-Received: by 2002:a05:690c:c6c2:b0:873:5bd1:98d1 with SMTP id 00721157ae682-88d24c2f9e5mr11127667b3.67.1789416724795;
        Mon, 14 Sep 2026 13:12:04 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:df87:8743:655b:3824])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-884894fd624sm40394117b3.46.2026.09.14.13.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:12:03 -0700 (PDT)
Message-ID: <cbc98010b9f6657e162cfcc6ac5ba6032e7b729d.camel@dubeyko.com>
Subject: Re: [PATCH v4 2/2] hfsplus: validate b-tree fork extents at mount
 time
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Date: Mon, 14 Sep 2026 13:12:01 -0700
In-Reply-To: <20260912132407.16856-3-ngocthang2710.1999@gmail.com>
References: <c6b841becc5b1709a9f54a1c0efd0a14f02ad97b.camel@dubeyko.com>
	 <20260912132407.16856-1-ngocthang2710.1999@gmail.com>
	 <20260912132407.16856-3-ngocthang2710.1999@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-12 at 20:24 +0700, Nguyen Ngoc Thang wrote:
> A hfsplus_check_fork() pass over a special file's eight fork extents,
> called from hfs_btree_open() for the extents, catalog and attributes
> trees:
>=20
> =C2=A0- block_count =3D=3D 0 but start_block !=3D 0: garbage left in a sl=
ot that
> =C2=A0=C2=A0 should be blank (this is what the syzbot-reported image has =
in the
> =C2=A0=C2=A0 extents overflow file's fork, slots 3 and 6);
> =C2=A0- start_block + block_count > sbi->total_blocks: an extent pointing
> =C2=A0=C2=A0 past the end of the volume;
> =C2=A0- a non-zero extent following a zero one: a hole in the used range.
>=20
> If the first extent itself fails these checks, the b-tree's location
> on disk is unknown and there is nothing to recover, so
> hfs_btree_open()
> fails as it already does for the other structural checks in that
> function, and the mount fails.
>=20
> If only a later extent is affected, the tree can still be opened (its
> first extent, and hence its root node, is fine); mark it corrupt and
> let the caller decide. hfsplus_fill_super() forces the volume
> read-only in that case, and hfsplus_reconfigure() checks the same
> per-tree flag on remount instead of re-deriving it, refusing to go
> back to read-write. attr_tree may be NULL (volumes without an
> attributes fork), so both checks guard for that.
>=20
> This also gives the previous patch's hfsplus_file_extend() fix a
> mount-time backstop: a fuzzed or damaged extents overflow fork like
> the one in the syzbot report is caught here before any write ever
> reaches it.
>=20
> Reported-by: syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>
> ---
> =C2=A0fs/hfsplus/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++++++++
> =C2=A0fs/hfsplus/extents.c=C2=A0=C2=A0=C2=A0 | 37 +++++++++++++++++++++++=
++++++++++++++
> =C2=A0fs/hfsplus/hfsplus_fs.h |=C2=A0 4 ++++
> =C2=A0fs/hfsplus/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++++++=
+
> =C2=A04 files changed, 62 insertions(+)
>=20
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 2ea8cd5658e1..0a05ade53070 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -293,6 +293,18 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id)
> =C2=A0		goto free_inode;
> =C2=A0	}
> =C2=A0
> +	switch (hfsplus_check_fork(sb, HFSPLUS_I(tree->inode)-
> >first_extents)) {

If we return error code for corrupted fork (that makes more sense),
then we don't need in switch here.

> +	case -EIO:
> +		pr_err("%s (cnid 0x%x) fork's first extent is
> corrupt\n",
> +			hfs_btree_name(id), id);
> +		goto free_inode;
> +	case 1:

I don't see the point returning 1 from the function. It should be error
code.

> +		pr_warn("%s (cnid 0x%x) fork has corrupt extents,
> forcing read-only.\n",
> +			hfs_btree_name(id), id);
> +		tree->corrupt =3D true;
> +		break;
> +	}
> +
> =C2=A0	mapping =3D tree->inode->i_mapping;
> =C2=A0	page =3D read_mapping_page(mapping, 0, NULL);
> =C2=A0	if (IS_ERR(page))
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index 236f2d9a7a2d..a9303ce5bf8f 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -95,6 +95,43 @@ static bool hfsplus_ext_fork_full(struct
> hfsplus_extent *ext)
> =C2=A0	return true;
> =C2=A0}
> =C2=A0
> +/*
> + * Check a fork's eight extents for the corruption a fuzzed or
> damaged
> + * volume header can contain: garbage in a slot that should be
> unused,
> + * an extent that runs past the end of the volume, or a used extent
> + * following an unused one.
> + *
> + * Returns 0 if the fork is fully consistent, 1 if only extents
> after
> + * the first are affected (the b-tree can still be located, so it's
> + * safe to mount read-only), or -EIO if the first extent itself is
> + * unusable.
> + */
> +int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent
> *ext)

Why not struct hfsplus_fork_raw here for check?

> +{
> +	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> +	bool seen_hole =3D false;
> +	int i;
> +
> +	for (i =3D 0; i < 8; i++, ext++) {

Ditto. Related to hardcoded value.

> +		u32 start =3D be32_to_cpu(ext->start_block);
> +		u32 count =3D be32_to_cpu(ext->block_count);
> +		bool bad;
> +
> +		if (!count) {
> +			bad =3D start !=3D 0;
> +			seen_hole =3D true;
> +		} else {
> +			bad =3D seen_hole || start + count < start ||
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start + count > sbi->total_blocks;
> +		}

I think that current logic of check looks complicated. And I think not
all possible cases are checked. For example, fork cannot be completely
empty. Could we rework the logic to be more clear? Maybe, we need to
introduce the function for extent check, function for checking the
extents are logically contiguous?

Also, the fork contains more details to check:

struct hfsplus_fork_raw {
	__be64 total_size;
	__be32 clump_size;
	__be32 total_blocks;
	hfsplus_extent_rec extents;
} __packed;

Why are we not check the fork itself?

> +
> +		if (bad)
> +			return i ? 1 : -EIO;

Ditto. Related to 1. I prefer to have error code instead.

> +	}
> +
> +	return 0;
> +}
> +
> =C2=A0static int __hfsplus_ext_write_extent(struct inode *inode,
> =C2=A0		struct hfs_find_data *fd)
> =C2=A0{
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 1e5b58e6a13f..8d47219e67d3 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -56,6 +56,9 @@ struct hfs_btree {
> =C2=A0	unsigned int max_key_len;
> =C2=A0	unsigned int depth;
> =C2=A0
> +	/* fork extents past the first were found corrupt at open
> time */
> +	bool corrupt;
> +

I don't want to say that this direction is wrong. However, we have
flags:

#define HFSPLUS_I_CAT_DIRTY	1	/* has changes in the catalog
tree */
#define HFSPLUS_I_EXT_DIRTY	2	/* has changes in the extent
tree */
#define HFSPLUS_I_ALLOC_DIRTY	3	/* has changes in the
allocation file */
#define HFSPLUS_I_ATTR_DIRTY	4	/* has changes in the
attributes tree */

And we are using inode's flag to track the dirty state of the tree.
Potentially, we can introduce the HFSPLUS_I_CORRUPT_TREE. And I think
one flags for all b-tree will be enough because inode is dedicated for
a particular tree. What do you think?

> =C2=A0	struct mutex tree_lock;
> =C2=A0
> =C2=A0	unsigned int pages_per_bnode;
> @@ -440,6 +443,7 @@ int hfsplus_free_fork(struct super_block *sb, u32
> cnid,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hfsplus_fork_raw *fork, int=
 type);
> =C2=A0int hfsplus_file_extend(struct inode *inode, bool zeroout);
> =C2=A0void hfsplus_file_truncate(struct inode *inode);
> +int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent
> *ext);
> =C2=A0
> =C2=A0/* inode.c */
> =C2=A0extern const struct address_space_operations hfsplus_aops;
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index ff7d6b3336a6..b65edb8ee589 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -400,6 +400,11 @@ static int hfsplus_reconfigure(struct fs_context
> *fc)
> =C2=A0			pr_warn("filesystem is marked journaled,
> leaving read-only.\n");
> =C2=A0			sb->s_flags |=3D SB_RDONLY;
> =C2=A0			fc->sb_flags |=3D SB_RDONLY;
> +		} else if (sbi->ext_tree->corrupt || sbi->cat_tree-
> >corrupt ||
> +				(sbi->attr_tree && sbi->attr_tree-
> >corrupt)) {

Currently, only hfsplus_fill_super() can detect the b-tree corruption.
Why do we have the check here? Do you mean that xattr b-tree can be
created and to be corrupted?

> +			pr_warn("a b-tree fork was corrupt at mount
> time, leaving read-only.\n");
> +			sb->s_flags |=3D SB_RDONLY;
> +			fc->sb_flags |=3D SB_RDONLY;
> =C2=A0		}
> =C2=A0	}
> =C2=A0	return 0;
> @@ -564,6 +569,10 @@ static int hfsplus_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	}
> =C2=A0	sb->s_xattr =3D hfsplus_xattr_handlers;
> =C2=A0
> +	if (sbi->ext_tree->corrupt || sbi->cat_tree->corrupt ||
> +	=C2=A0=C2=A0=C2=A0 (sbi->attr_tree && sbi->attr_tree->corrupt))
> +		sb->s_flags |=3D SB_RDONLY;

If we fail to check any b-tree, then logic should stop. Why haven't we
checked the error code of hfs_btree_open()?

Thanks,
Slava.

> +
> =C2=A0	inode =3D hfsplus_iget(sb, HFSPLUS_ALLOC_CNID);
> =C2=A0	if (IS_ERR(inode)) {
> =C2=A0		pr_err("failed to load allocation file\n");
