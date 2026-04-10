Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F12BD5B9
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 06:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803624; cv=none; b=dwoLeQaBQLHhNCZ6UvvUXU0WX4fEedKERwH1ZmcmyfABfCB/PBjUlxO5/G+hainCe/MXgIPm4FmhKfSXnMnmwS01sxXAvFfvtJG0Fd/YF44wPd1T07ckL+X/L+qB7wOAkBLTpf9xXJx06yoAt+6peKj4y+HxdU7aP8Gf0TfbsJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803624; c=relaxed/simple;
	bh=KsxLF3DCLTdOtxD995G1lTLjDLdi/K2Z8eVxn8pdCSg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vl+sUiyRcxzeLqBffh5XcQ9aw66EBVo7GF6hTECbWXtHlvnT1ZObzh7M0Kff/lkzcBLBB7maK+MjPvX3ZQ9eH/Au0/8BF47tiuEupwrESEDO423jTATOYKZ5hv91kIzH68wP3+dOOLINf6hZHwUCnscw+1015KzC2VaBkAMa5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhJfgAdV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhJfgAdV"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so1575477f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 23:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775803621; x=1776408421; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xkJhung2ozHU+Fpx7n1C/vMEwaxo6uNBxz41h3N6gIA=;
        b=WhJfgAdVN3dp04F6Uc9baS0dW1Dg3bSsYfu2rE1GnAoQojpaMqfcNlLoB2AeXmuTEY
         L5sXt9OnnEk+ROcM8iWfU8eFWfCZIEVvCHhTeuPy41t+diq9CSVvmeboRMk4FgFU90VW
         UU2TxW3dVBoTwxdBGtTVKY9jPznM0ChadPsPnCpeAKbwiL4S6bVOvRxI4dUMwbsXEit+
         TSw0FtYS/s5uF4b+TC6ti2wA3+wGruV3GxZX9m7JGuR0+uDrbeONMSXse+fkb62dYVEh
         DcS6jhBAg+US4UIdqCXwcO0fjey8wrbrUDAZl/89LWrYj9D+UUd4Y71u1PMUc2Nfz+q/
         ey6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775803621; x=1776408421;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkJhung2ozHU+Fpx7n1C/vMEwaxo6uNBxz41h3N6gIA=;
        b=JPGnTeRr/pEdGJ1LcXaS6TL4XGLPPgA5nRQnN1owb0/4bRY9ccN2FVs0qtSMhM0T74
         zTQIONJPYHUSkWNx0fJSafq1Zz2iHLXNoRat+sN+OVBq9JRTeQ9C8RQ85tpTK2Xola66
         +je9Vh8tFL7o25jNXGS6BYROiCr4RGCBRjlE8SPie0WiyVQx0NzXgFEvuDWdxXELdWhY
         PniSkHnJqAandz05GO/bP7WA2gluQSzVLaAcQbrX116yWLYuwZCG+55tYaJ+63tzNJlF
         pu9YCSBMG2WlPyW1apPa0eZ8Uux35C1rbguyDiCZeB29goYM9EZZoi1vdHL4asgwuduZ
         C1/g==
X-Gm-Message-State: AOJu0YxmCkUBi8U3UegdAs1E+Bhzf4JDyDLoptFxjvGw/1wJetuPUdw3
	l8v5ixK0hOIYPoirRUAQEKUKlXJLG4ni1TgWIDCdRRDt80iBCC9yDZWa
X-Gm-Gg: AeBDieuik2ND0YOk4hmEIDNbgOGe59eeG8eXLSmprc8dVwOZ6nFT7hETzM/5bDNPZRh
	Y0aHTp8iQbyOHZdpBSf7o34RHUO+p+ZllvJhhQjVhDtk26R7xhbIzfgDgDCyHPKooBmOcU6z6p5
	LeZmlv8SVRZzKhr85Crbl0C3oLTGITKRQBtP2XvfF7FUoj8yI9ZxMVdHw+1wurK4EoCH7qaNbka
	PBsPTYOnslmV3IWKVzK3h4XG9PGHonwTt+Atpw2wtgC8P5Lhqg5IBf7R1ZQ0j1mgETAiP2eCFne
	xTad0jaeFctzAoq4+/axI10bC7cEygP9EIBe1ft/n+fbRNPr/0fuJbo2UUTze/6pWHW3LThtts+
	uzddEOzVYkcuUBb5pbD1wT0/knneoG9xgZhRzLj0PYnoMzZJlmz7Ms5WwAFUl08X/M7b2kloFo1
	nYLa3DR6l+GS9UJjyoYTM=
X-Received: by 2002:a5d:5d02:0:b0:43d:1df7:ed24 with SMTP id ffacd0b85a97d-43d642a64b1mr2658295f8f.21.1775803621116;
        Thu, 09 Apr 2026 23:47:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a69sm4969375f8f.4.2026.04.09.23.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 23:47:00 -0700 (PDT)
Date: Fri, 10 Apr 2026 09:46:57 +0300
From: Dan Carpenter <error27@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] ntfs: update mft operations
Message-ID: <adic4W19jh0_xQ1n@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Namjae Jeon,

Commit 115380f9a2f9 ("ntfs: update mft operations") from Feb 13, 2026
(linux-next), leads to the following Smatch static checker warning:

	fs/ntfs/mft.c:2823 ntfs_write_mft_block()
	error: uninitialized symbol 'rl'.

fs/ntfs/mft.c
    2697 static int ntfs_write_mft_block(struct folio *folio, struct writeback_control *wbc)
    2698 {
    2699         struct address_space *mapping = folio->mapping;
    2700         struct inode *vi = mapping->host;
    2701         struct ntfs_inode *ni = NTFS_I(vi);
    2702         struct ntfs_volume *vol = ni->vol;
    2703         u8 *kaddr;
    2704         struct ntfs_inode **locked_nis __free(kfree) = kmalloc_array(PAGE_SIZE / NTFS_BLOCK_SIZE,
    2705                                                         sizeof(struct ntfs_inode *), GFP_NOFS);
    2706         int nr_locked_nis = 0, err = 0, mft_ofs, prev_mft_ofs;
    2707         struct inode **ref_inos __free(kfree) = kmalloc_array(PAGE_SIZE / NTFS_BLOCK_SIZE,
    2708                                                               sizeof(struct inode *), GFP_NOFS);
    2709         int nr_ref_inos = 0;
    2710         struct bio *bio = NULL;
    2711         u64 mft_no;
    2712         struct ntfs_inode *tni;
    2713         s64 lcn;
    2714         s64 vcn = ntfs_pidx_to_cluster(vol, folio->index);
    2715         s64 end_vcn = ntfs_bytes_to_cluster(vol, ni->allocated_size);
    2716         unsigned int folio_sz;
    2717         struct runlist_element *rl;
    2718         loff_t i_size = i_size_read(vi);
    2719 
    2720         ntfs_debug("Entering for inode 0x%llx, attribute type 0x%x, folio index 0x%lx.",
    2721                         ni->mft_no, ni->type, folio->index);
    2722 
    2723         if (!locked_nis || !ref_inos)
    2724                 return -ENOMEM;
    2725 
    2726         /* We have to zero every time due to mmap-at-end-of-file. */
    2727         if (folio->index >= (i_size >> folio_shift(folio)))
    2728                 /* The page straddles i_size. */
    2729                 folio_zero_segment(folio,
    2730                                    offset_in_folio(folio, i_size),
    2731                                    folio_size(folio));
    2732 
    2733         lcn = lcn_from_index(vol, ni, folio->index);
    2734         if (lcn <= LCN_HOLE) {
    2735                 folio_start_writeback(folio);
    2736                 folio_unlock(folio);
    2737                 folio_end_writeback(folio);
    2738                 return -EIO;
    2739         }
    2740 
    2741         /* Map folio so we can access its contents. */
    2742         kaddr = kmap_local_folio(folio, 0);
    2743         /* Clear the page uptodate flag whilst the mst fixups are applied. */
    2744         folio_clear_uptodate(folio);
    2745 
    2746         for (mft_ofs = 0; mft_ofs < PAGE_SIZE && vcn < end_vcn;
    2747              mft_ofs += vol->mft_record_size) {
    2748                 /* Get the mft record number. */
    2749                 mft_no = (((s64)folio->index << PAGE_SHIFT) + mft_ofs) >>
    2750                         vol->mft_record_size_bits;
    2751                 vcn = ntfs_mft_no_to_cluster(vol, mft_no);
    2752                 /* Check whether to write this mft record. */
    2753                 tni = NULL;
    2754                 if (ntfs_may_write_mft_record(vol, mft_no,
    2755                                         (struct mft_record *)(kaddr + mft_ofs),
    2756                                         &tni, &ref_inos[nr_ref_inos])) {
    2757                         unsigned int mft_record_off = 0;
    2758                         s64 vcn_off = vcn;
    2759 
    2760                         /*
    2761                          * Skip $MFT extent mft records and let them being written
    2762                          * by writeback to avioid deadlocks. the $MFT runlist
    2763                          * lock must be taken before $MFT extent mrec_lock is taken.
    2764                          */
    2765                         if (tni && tni->nr_extents < 0 &&
    2766                                 tni->ext.base_ntfs_ino == NTFS_I(vol->mft_ino)) {
    2767                                 mutex_unlock(&tni->mrec_lock);
    2768                                 atomic_dec(&tni->count);
    2769                                 iput(vol->mft_ino);
    2770                                 continue;
    2771                         }
    2772 
    2773                         /*
    2774                          * The record should be written.  If a locked ntfs
    2775                          * inode was returned, add it to the array of locked
    2776                          * ntfs inodes.
    2777                          */
    2778                         if (tni)
    2779                                 locked_nis[nr_locked_nis++] = tni;
    2780                         else if (ref_inos[nr_ref_inos])
    2781                                 nr_ref_inos++;
    2782 
    2783                         if (bio && (mft_ofs != prev_mft_ofs + vol->mft_record_size)) {
    2784 flush_bio:
    2785                                 bio->bi_end_io = ntfs_bio_end_io;
    2786                                 submit_bio(bio);
    2787                                 bio = NULL;
    2788                         }
    2789 
    2790                         if (vol->cluster_size < folio_size(folio)) {
    2791                                 down_write(&ni->runlist.lock);
    2792                                 rl = ntfs_attr_vcn_to_rl(ni, vcn_off, &lcn);

rl is assigned here.

    2793                                 up_write(&ni->runlist.lock);
    2794                                 if (IS_ERR(rl) || lcn < 0) {
    2795                                         err = -EIO;
    2796                                         goto unm_done;
    2797                                 }
    2798 
    2799                                 if (bio &&
    2800                                    (bio_end_sector(bio) >> (vol->cluster_size_bits - 9)) !=
    2801                                     lcn) {
    2802                                         bio->bi_end_io = ntfs_bio_end_io;
    2803                                         submit_bio(bio);
    2804                                         bio = NULL;
    2805                                 }
    2806                         }
    2807 
    2808                         if (!bio) {
    2809                                 unsigned int off;
    2810 
    2811                                 off = ((mft_no << vol->mft_record_size_bits) +
    2812                                        mft_record_off) & vol->cluster_size_mask;
    2813 
    2814                                 bio = bio_alloc(vol->sb->s_bdev, 1, REQ_OP_WRITE,
    2815                                                 GFP_NOIO);
    2816                                 bio->bi_iter.bi_sector =
    2817                                         ntfs_bytes_to_sector(vol,
    2818                                                         ntfs_cluster_to_bytes(vol, lcn) + off);
    2819                         }
    2820 
    2821                         if (vol->cluster_size == NTFS_BLOCK_SIZE &&
    2822                             (mft_record_off ||
--> 2823                              rl->length - (vcn_off - rl->vcn) == 1 ||
                                      ^^^^^^^^^^
this warning looks reasonable to me, but the code is a bit complicated.

    2824                              mft_ofs + NTFS_BLOCK_SIZE >= PAGE_SIZE))
    2825                                 folio_sz = NTFS_BLOCK_SIZE;
    2826                         else
    2827                                 folio_sz = vol->mft_record_size;
    2828                         if (!bio_add_folio(bio, folio, folio_sz,
    2829                                            mft_ofs + mft_record_off)) {
    2830                                 err = -EIO;
    2831                                 bio_put(bio);
    2832                                 goto unm_done;
    2833                         }
    2834                         mft_record_off += folio_sz;
    2835 
    2836                         if (mft_record_off != vol->mft_record_size) {
    2837                                 vcn_off++;
    2838                                 goto flush_bio;
    2839                         }
    2840                         prev_mft_ofs = mft_ofs;
    2841 
    2842                         if (mft_no < vol->mftmirr_size)
    2843                                 ntfs_sync_mft_mirror(vol, mft_no,
    2844                                                 (struct mft_record *)(kaddr + mft_ofs));
    2845                 } else if (ref_inos[nr_ref_inos])
    2846                         nr_ref_inos++;
    2847         }
    2848 
    2849         if (bio) {

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
