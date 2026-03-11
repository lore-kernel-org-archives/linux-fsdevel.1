Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08FA2DE6E3
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261124; cv=none; b=ApM2YO5tGZRVLu5OcmtOWOu/CM437XU6u/o86cHphShP0b1UX7thqklsFaY1sPTscD4qoy1NGsLqZw8vqTIVbTjTZJrbskH5CtouvKFR72u2BwkTZLVl6uGGLAm5FuTXLA4ORvzcHhG1vp7zzpZkz9eTBcE7U/XKGhyEwzb+xqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261124; c=relaxed/simple;
	bh=SklFJCE4rJH+jjAqDUMkL7Ol3Uw1eFZiry/NRZn7Zz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIdwiqiOas9uvuglwRrY/3uD2npnxMbNlkiF3IG8TsGcMQq4csS8CSZYXZy2L1xB2jSElSM0/gWUY+r/GZc/On0Qh4ca5IVblulr6bZCUVjxIQfVSLqXopn5EISNPtwIhcjS9GLyxz/dERkWa9BAylau3cjfiXMP6V8XN853BRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=KcBEEaMF; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="KcBEEaMF"
Date: Wed, 11 Mar 2026 20:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1773261110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=766I6MQg8obxXmHnHCKMHu9EUOissOyjoiPdOsYfysU=;
	b=KcBEEaMFiprk5mJy1H4hrr19Dg8lwnmHFbnqYZ870sTPwdEAsxpbSGozTLeVgEFSSfyP9t
	ilPeugiup014KQtCA0ZijAc6n6c53LkGEnYId2ph+0OIsgJcg0VMeOXRpjQypEGGMpDWbk
	sU29Mug4fBL61dW6OH7AKIufhLa99wUcSNtFoRPsE7+/BE/KkbD5WArcbl/h7ljT+l3oxd
	khQkRQ6LCvtnRE02YM0KIEM0FW2pqj2s884nCrJ4BNm1JGes1HjY1d8zuoHn16RV6na5YM
	v54Nl/9naZcT0ewxJPA5Ur/C7ijHWZ+4a5SJKak0ZysduFQox4E0bNQMIF4XRQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com" <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] hfs: Validate CNIDs in hfs_read_inode
Message-ID: <abHRKnUIqMxTmcWH@Bertha>
References: <20260310000826.242674-1-contact@gvernon.com>
 <fe598b9b8686708d5145fee8963abbfb726fbdfd.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe598b9b8686708d5145fee8963abbfb726fbdfd.camel@ibm.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 10, 2026 at 09:28:53PM +0000, Viacheslav Dubeyko wrote:
> On Tue, 2026-03-10 at 00:08 +0000, George Anthony Vernon wrote:
> > hfs_read_inode previously did not validate CNIDs read from disk, thereby
> > allowing inodes to be constructed with disallowed CNIDs and placed on
> > the dirty list, eventually hitting a bug on writeback.
> > 
> > Validate reserved CNIDs as specified for HFS according to
> > "Inside Macintosh: Files."
> > 
> > This issue was discussed at length on LKML previously, the discussion
> > is linked below.
> > 
> > Syzbot tested this patch on mainline and the bug did not replicate.
> > This patch was regression tested by issuing various system calls on a
> > mounted HFS filesystem and validating that file creation, deletion,
> > reads and writes all work.
> > 
> > Link: https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_all_427fcb57-2D8424-2D4e52-2D9f21-2D7041b2c4ae5b-40&d=DwIDAg&c=BSDicqBQBDjDI9RkVyTcHQ&r=q5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=AzLgd6KhZfr8AykzDg76T-sDUALdUDSC68BUfheUxxhq-KIglGTX6mtAci6dTupM&s=nuXDj9Z8fvUpvnJIyDsfPIi-YuBzvbXxQUhypXeaheU&e= 
> > I-love.SAKURA.ne.jp/T/
> > Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> > Closes: https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_bug-3Fextid-3D97e301b4b82ae803d21b&d=DwIDAg&c=BSDicqBQBDjDI9RkVyTcHQ&r=q5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=AzLgd6KhZfr8AykzDg76T-sDUALdUDSC68BUfheUxxhq-KIglGTX6mtAci6dTupM&s=lGn13lU4-Np727qrFQB17Y-qYKD4fRkJ3gSkQYQH8cg&e= 
> > Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> > Signed-off-by: George Anthony Vernon <contact@gvernon.com>
> > ---
> > 
> > Sorry there was a long wait for V3! I have now reviewed the feedback
> > given in response to V2, which I very greatly appreciate.
> > 
> > Most of the changes here are directly implementing changes requested. I
> > disagree that CNID 5 should be considered valid and have added some
> > comments referencing the documentation. This is linked to the change
> > from is_valid_cnid() -> is_valid_catalog_record(). I believe it is now
> > semantically correct, because CNID 5 is a valid CNID, but it can not
> > belong to a catalog record.
> > 
> > Thanks,
> > 
> > George
> > 
> > Changes from V2->V3:
> > - Use HFS-specific references in preference to TN1150
> > - Remove Tetsuo's additional superblock check from patch series
> > - Rename is_valid_cnid() -> is_valid_catalog_record()
> > - Add static inline hfs_inode_type() helper function
> > - Do not BUG() on detected bad inode, use pr_warn()
> > 
> > Changes from V1->V2:
> > - is_valid_cnid prototype now takes u32 and u8 types
> > - Add fsck advice in dmesg
> > - Replace make_bad_inode calls in hfs_read_inode with gotos
> > - Reuse same check in hfs_write_inode
> > - Disallow HFS_POR_CNID, HFS_BAD_CNID, and HFS_EXCH_CNID
> > - Add Tetsuo's patch to mine and make it a patch series
> > 
> >  fs/hfs/inode.c | 76 ++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 62 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> > index 878535db64d6..db31b9840371 100644
> > --- a/fs/hfs/inode.c
> > +++ b/fs/hfs/inode.c
> > @@ -340,6 +340,42 @@ static int hfs_test_inode(struct inode *inode, void *data)
> >  	}
> >  }
> >  
> > +/*
> > + * is_valid_catalog_record
> > + *
> > + * Validate the CNID of a catalog record
> > + */
> > +static inline
> > +bool is_valid_catalog_record(u32 cnid, u8 type)
> > +{
> > +	if (likely(cnid >= HFS_FIRSTUSER_CNID))
> > +		return true;
> > +
> > +	switch (cnid) {
> > +	case HFS_ROOT_CNID:
> > +		return type == HFS_CDR_DIR;
> > +	case HFS_EXT_CNID:
> > +	case HFS_CAT_CNID:
> > +		return type == HFS_CDR_FIL;
> > +	case HFS_POR_CNID:
> 
> If we don't process this ID, then default case will be completely enough. We
> don't need to introduce this as a special case.
> 
Okay, I've removed it. It was an intentional style choice, the purpose
was to provide some explanation.

> > +		/* No valid record with this CNID */
> > +		break;
> > +	case HFS_BAD_CNID:
> > +		/*
> > +		 * Bad block file "doesn't have a file record in the catalog" as per TN1150 (HFS+).
> > +		 * Inside Macintosh: Files chapter 5-8 tells us for plain old HFS:
> > +		 * "... the bad block sparing algorithm does not create any new
> > +		 * entries in the volume's catalog file".
> > +		 */
> 
> Yes, HFS driver (bad block sparing algorithm) will not create this file because
> this file could be created by mkfs tool. And the bad block sparing algorithm
> could simply read this file and add new items (bad sectors). This CNID could be
> in Catalog File because it could be created by mkfs tool.
> 
> Anyway, I think that probability to have the Bad block file is really low. If
> you really insist not to process this CNID, then I suggest completely remove
> this case and comments.
> 
Ditto here, I thought the comments were useful explanation, I've removed
them. I really think it is correct not to parse this CNID. I think mkfs
would be violating the HFS standard if it created a CNID with that
inode.
> > +		break;
> > +	default:
> > +		/* Invalid reserved CNID */
> > +		break;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  /*
> >   * hfs_read_inode
> >   */
> > @@ -369,6 +405,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
> >  	rec = idata->rec;
> >  	switch (rec->type) {
> >  	case HFS_CDR_FIL:
> > +		if (!is_valid_catalog_record(rec->file.FlNum, HFS_CDR_FIL))
> > +			goto make_bad_inode;
> 
> I think to use the rec->type is better here than HFS_CDR_FIL.
> 
Thanks for pointing this out, after rewriting it the way you suggested I saw a further improvement to let the helper take a single hfs_cat_rec pointer.

> 
> >  		inode->i_ino = be32_to_cpu(rec->dir.DirID);
> >  		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
> >  		HFS_I(inode)->fs_blocks = 0;
> > @@ -399,8 +439,13 @@ static int hfs_read_inode(struct inode *inode, void *data)
> >  		inode->i_op = &hfs_dir_inode_operations;
> >  		inode->i_fop = &hfs_dir_operations;
> >  		break;
> > +	make_bad_inode:
> > +		pr_warn("Invalid cnid %lu\n", inode->i_ino);
> > +		pr_warn("Volume is probably corrupted, try performing fsck.\n");
> > +		fallthrough;
> >  	default:
> >  		make_bad_inode(inode);
> > +		break;
> >  	}
> >  	return 0;
> >  }
> > @@ -448,6 +493,11 @@ void hfs_inode_write_fork(struct inode *inode, struct hfs_extent *ext,
> >  					 HFS_SB(inode->i_sb)->alloc_blksz);
> >  }
> >  
> > +static inline u8 hfs_inode_type(struct inode *inode)
> > +{
> > +	return S_ISDIR(inode->i_mode) ? HFS_CDR_DIR : HFS_CDR_FIL;
> > +}
> > +
> >  int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
> >  {
> >  	struct inode *main_inode = inode;
> > @@ -460,20 +510,18 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
> >  	if (res)
> >  		return res;
> >  
> > -	if (inode->i_ino < HFS_FIRSTUSER_CNID) {
> > -		switch (inode->i_ino) {
> > -		case HFS_ROOT_CNID:
> > -			break;
> > -		case HFS_EXT_CNID:
> > -			hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
> > -			return 0;
> > -		case HFS_CAT_CNID:
> > -			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
> > -			return 0;
> > -		default:
> > -			BUG();
> > -			return -EIO;
> > -		}
> > +	if (!is_valid_catalog_record(inode->i_ino, hfs_inode_type(inode)))
> > +		return -EIO;
> > +
> > +	switch (inode->i_ino) {
> > +	case HFS_EXT_CNID:
> > +		hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
> > +		return 0;
> > +	case HFS_CAT_CNID:
> > +		hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
> > +		return 0;
> > +	default:
> > +		break;
> 
> Why this has been removed:
> 
> -		default:
> -			BUG();
> -			return -EIO;
> -		}
> 
> 
It hasn't been totally removed, the same logic has been absorbed into
is_valid_catalog_record(). The difference is now we just return -EIO
instead of throwing BUG() like you previously suggested, which I now
agree with.
> >  	}
> >  
> >  	if (HFS_IS_RSRC(inode))
> 
> 
> You completely missed the hfs_fill_super() logic:
> 
> 	root_inode = hfs_iget(sb, &fd.search_key->cat, &rec);
> 	hfs_find_exit(&fd);
> 	if (!root_inode)
> 		goto bail_no_root;
> 
> We need to process it specially now because we've created bad inode.
> 
> Thanks,
> Slava.

Sorry I did miss this. I agree that this change will be sufficient to
check the superblock, it's functionally equivalent to Tetsuo's patch.

Will follow up with new patch shortly.

Thanks again,

George
