Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AC6463B68
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127197; cv=none; b=GqvTDBRgJ8vFpUbQFoBUTjjjO0LHpJ+URSHJu4gT2JDlh2GkjF4/bEAIyOR2ovTKfJeWCBEvF7/OHBBViCUBWy4WeTGceVLJCenIHACv5R1s3nFDIu9mnJz8l7soUkxBA5iw/9sZGm48l8oKKXnbjRYjqAg17WXVJUUGP4MrTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127197; c=relaxed/simple;
	bh=DqmJQsgUpf4KBnCVC/WyqGYQ2UH9L00dFVSrd0E5b+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OD9yBDOa/1dyrVTYBnTXG5KOz3QiXM4Wr7Y9+2fhBJbHdnA//2ZfnNfGZuFWQaL/Hl0gEqPouVX6Bh8uAPu7L8X3gqXZ52GRGeVYP6N3hPuCCBZywA/yZ9rgaTKTjIMKEJxMhKEhNkTyjYLT7RaH/p/1OFPHmrOTHq3gL1JkGjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIZiFMOX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIZiFMOX"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8558c0b26a8so564424b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 04:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789127195; x=1789731995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P0d2aRvLBFsZ2DWV9mXwS41WTqPgM5PBo/dZ4iSn2uA=;
        b=cIZiFMOX8WGsaTjkxAc+eXStHK5765l0tF2Oa8IgJo7jVUyCaPcd5IlEN7BgC8f3pa
         VpMxjeJvpIyBQXyyNBA3FPXxHaR80P6G7FVOeBn+e0D1wUcWy+x4OfqNdrtHSBne/PIB
         SnCaTlvpNeOzD/4vLe3AaBXtofYK0sA2CEujygpfkL9QfFwCScsn0g1BhV7vZoV7U6Xz
         DXp6zIdmpOsLctPdgonNCSGjJLjRdf5fExAhui60WW+SrEkuUMHnGTgrD47h1kpBOOTz
         F5Vir3iwDjJHqGESGKOinAVM85bcfhbvuQXyxNeq6S1riXoMh+RjOuD0A8frnuakF7ya
         mpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789127195; x=1789731995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P0d2aRvLBFsZ2DWV9mXwS41WTqPgM5PBo/dZ4iSn2uA=;
        b=nYFpvfmTM4o5TwTn++XwUdZ1ISBP9oELCZs7fw1sOq8cA1ykVQUPoFkvJA19sOns5U
         fv0ZXZt7b37zlvN9k61r3Sm1p/5K94abKUu3fKQkZYApGwJJJNm0dGLeKBGmpav9nUmo
         36q/qZi1rem1VGzfCmXdDAqaEDYdzXBQTtakJzL6TiXYa6huSnLsksK8qI6dkeU+greG
         Dim69dk7Ewejf/ODaEyLr+gqxMAa0I4WSgE3eCzH1r99Koi/IaVCHyCclG6El1h8k+Qg
         XPA1Rlg8cAO1dl9WE598rRrpePzYsLj49NGJ8sc5bLgcrAiuyTGIBtImWcOiZX1Oy0Rf
         WCKw==
X-Forwarded-Encrypted: i=1; AKwUvBy0fKKs1XDbK8xl8zzYjPZc7xBdlA2JrieeUHtWJjeMFp8DEbTzR5HImDG4udt6dmCnV7/C97JENwA1ZFVI@vger.kernel.org
X-Gm-Message-State: AFuF++lf/z+fsMDczLjSyCLseXtsGJV1noMcXr/2eap0758DQX4CMSFq
	VAFvOyY1LAj8+VzB0CxSnydjpnyCjko48nUgaBXl6ckJip/fGZNwEDKU
X-Gm-Gg: AYBFou09iZ5dWkhNjSM6RTRCTilSEZgetybzwTfc/4RURHV7FBcn7eiEvAO3P0hGnZ9
	g1DZZY5zR3roo3pyLdSRdv4SMhQXldlgjEtjPYN9r3Ml7+VKvfLx2NLRTx6z7NZNP/vxezaDzg1
	n0/7NYEFapEyR4/nIA151itWc5DwHm+ZT4h4aGDVIO+M2kgvoglm/5V8Xml9eRCWiMS9mov3NPL
	UwBO6b7aseiRRz4v+fVl5c5y7E5/nFNrCeotgU9B0dI0lJkNvS+P1fBV21b9duF8HLjp2Azymrl
	ES9Pxv7HtiKfzhvtwXgSVFeScC63K773tPjrcrExRp6XOP0rIBHQWeQCy9P9xHFJKdCx6GaUiNJ
	Ogvq4OLzFGgSBF5OroZufxkOje3oC3kja/ZaNHpNHZNpchaUFHLWjwdDmD8hK7ntClBRvdMYFg/
	8Scpiw2GyXeBqgB8O14HhTqNLJI97NyZko2UHyAmkl0xc5lGMMeS7S97zi201MrR5R8DrJyahZt
	o6vlggH8OHubv1nk5w=
X-Received: by 2002:a05:6a00:190f:b0:847:9267:2104 with SMTP id d2e1a72fcca58-86b2fb16751mr6046446b3a.12.1789127194737;
        Fri, 11 Sep 2026 04:46:34 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d38:5c70:b928:dcab:35a4:adf0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29ebc712sm971495b3a.49.2026.09.11.04.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:46:33 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Subject: Re: [PATCH] hfsplus: fix recursive tree_lock in hfsplus_file_extend()
Date: Fri, 11 Sep 2026 18:46:28 +0700
Message-ID: <20260911114628.10349-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <28f33649277ca654e66c36aea1bd4f2bfd6abbf6.camel@dubeyko.com>
References: <28f33649277ca654e66c36aea1bd4f2bfd6abbf6.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

> I assume that if we are here, then we already allocated the blocks
> for the extent. And if we simply return the error here, then we've
> lost these allocated blocks from the free space. Am I right? I
> think we need to prevent the blocks allocation, then.

You're right, that was a real bug -- hfsplus_block_allocate() already
ran by the time we reach insert_extent, so returning straight from
there leaked start..start+len from the free space permanently. Fixed
by freeing them back before returning:

--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -537,6 +537,15 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	return res;

 insert_extent:
+	/*
+	 * Getting here means the fork's eight extents are exhausted (see
+	 * hfsplus_add_extent()). The extents overflow file can't record
+	 * an overflow extent of its own, so it cannot grow any further;
+	 * give back the blocks just allocated for it above.
+	 */
+	if (inode->i_ino == HFSPLUS_EXT_CNID) {
+		if (hfsplus_block_free(sb, start, len))
+			pr_err("can't free extent: start %u, count %u\n",
+				start, len);
+		res = -ENOSPC;
+		goto out;
+	}
+
 	hfs_dbg("insert new extent\n");
 	res = hfsplus_ext_write_extent_locked(inode);

> I think your logic here that if we try to read the extent from the
> Extents Overflow file's content for the file itself, then something
> is going wrong. In this case, we need to place this check into
> hfsplus_ext_read_extent().

Agreed, moved it there -- it's the one place that actually calls
hfs_find_init() again, so this is now the single point enforcing the
invariant instead of duplicating it at each caller:

--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -216,6 +216,14 @@ static int hfsplus_ext_read_extent(struct inode *inode, u32 block)
 	    block < hip->cached_start + hip->cached_blocks)
 		return 0;

+	/*
+	 * The extents overflow file is fully described by its own fork
+	 * extents; looking up an overflow extent for it would re-enter
+	 * hfs_find_init() on the extents tree, whose tree_lock may already
+	 * be held by the caller.
+	 */
+	if (inode->i_ino == HFSPLUS_EXT_CNID)
+		return -ENOSPC;
+
 	res = hfs_find_init(HFSPLUS_SB(inode->i_sb)->ext_tree, &fd);

This retires the guard I'd put in hfsplus_file_extend()'s else branch
(same check, called from the one place that mattered) -- v3 is net
smaller than v2. hfsplus_get_block()'s existing check at extents.c:261
(-EIO, before extents_lock is even taken) stays as-is; different
errno, different purpose -- fast rejection of a read, not an
allocation failure -- not an oversight.

> But I still don't see how we will check the fork itself because it
> could be corrupted even without be completely full? And how could
> we check the forks of other b-trees?

Fair, you've asked this three times now and I keep pushing it to
"follow-up" without saying what's in it, so concretely: a
hfsplus_check_fork(sb, fork, cnid) called from hfsplus_fill_super()
for ext_file/cat_file/attr_file, rejecting a fork where, for any of
the eight extents, block_count == 0 but start_block != 0 (garbage
in a slot that should be blank -- exactly what's in the syzbot image,
slots 3 and 6), or start_block + block_count > sbi->total_blocks
(extent points outside the volume), or a non-zero extent follows a
zero one (a hole in the middle of the used range). Wired into your
severity split: first extent fails those checks -> hfs_btree_open()
returns an error, mount fails; only later extents fail -> open the
tree, mark it inconsistent, force read-only. I'll send that as a
separate patch once this one lands, since it touches mount-time
behavior for all three trees and deserves review on its own.

Both hunks above build cleanly here.

Thanks,
Thang
