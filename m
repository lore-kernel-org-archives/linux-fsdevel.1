Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F381A23A6;
	Tue, 25 Aug 2026 05:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787636922; cv=none; b=o2YXXWNEFSvMoDE7q0YAhGviucMcC7oGHw2QssyC3npY+mz9ciSK7NXVcaenpMXsir135Aw3Thmbt0EqRuL0ARB51GNHUNRfvdAKFIHzO8+Ege05Z8HaCjfUAWDPJukTq/zB4/ZUqAHNyRXhwsh4hE6k4MnlvJHwcCMnRCqCoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787636922; c=relaxed/simple;
	bh=VZSugPprpc+DoEFXtTGM/iet3OY75GM034V69uCgtus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDSyQFz94/csPNqd3Pf9XPp1MONRT4HEr3HuLQ5j0qt/Vy3a9/qH5IEBbmytRv7f7PSXuqlzK5KCJ147iOdYyV1asez0H7x4dackjyB/9LVvzyEwnzmz5FaOn3glm9UQekYnDp1XLsOgZU3rJ9Wukccs9GAZoipeMPiuyTQxDoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S2rGP7x2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2rGP7x2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HFDnRsAw55zolKK+KEfWLFf2Cew1IzCwKp3SV1h9ny0=; b=S2rGP7x2afrlPeM7TeFX/GgDAb
	J/pPXDGI4vv42X7cRxn9b9UqXR+bf/fFu4/5++cnanKpailmvj5ESbtZA1tP2zEJGE/mTMQDo4Xim
	EyFsIZ1wbBmDEliMGytpCYBqsHfH8KnqbbuyAr19ILsL+Uy9capB9//lHN36nD3sQ7Zp9zu//EuP+
	Q/MFnC0zZ9ahzeM0HvFvNUYnt0fhEPKdoL0JQmMnjZkYCAa84HAU91hh1IWSTa07+H3riOgio5ULW
	ssGReOnlnyEypSMOEBn8GkDtukvmKss6QrAc9vgC+uosveJaDhkMyWFQFJ3K27qa4yjs5f5Z+H7Qz
	z2c+nhXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyk1W-00000000CeW-0gyC;
	Tue, 25 Aug 2026 05:48:38 +0000
Date: Mon, 24 Aug 2026 22:48:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wenjie Qi <qwjhust@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, qiwenjie@xiaomi.com,
	Jens Axboe <axboe@kernel.dk>, Tal Zussman <tz2294@columbia.edu>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] f2fs: complete dropbehind write bios in safe task
 context
Message-ID: <ao0stlR57iUgrY2Y@infradead.org>
References: <20260820071438.695893-1-qiwenjie@xiaomi.com>
 <cover.1787564706.git.qiwenjie@xiaomi.com>
 <ef06bf67db77a009d5fc2932069c2b3366d972c4.1787564706.git.qiwenjie@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef06bf67db77a009d5fc2932069c2b3366d972c4.1787564706.git.qiwenjie@xiaomi.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 24, 2026 at 06:33:46PM +0800, Wenjie Qi wrote:
> Buffered RWF_DONTCACHE writes invalidate dropbehind folios from writeback
> completion. Keep normal and dropbehind folios in separate write bios, and
> defer dropbehind bios to sbi->wq unless completion runs in preemptible task
> context.
> 
> Use an F2FS-local context check for this decision. Task context alone is
> not sufficient: preemption may still be disabled, or completion may run in
> a preemptible RCU read-side critical section.
> 
> Keep the existing large-ATC deferral unchanged.

Please reuse all the helpers added in common code in 7.3 for deferring
bios and tsting if that that is neeeded instead of badly reinventing
the logic.  It also is really helpful to Cc people involved with the
code and the relevant mailing lists.

> 
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>  fs/f2fs/data.c | 50 ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 6ae0eb37d20..774a3e2d8e3 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -21,6 +21,7 @@
>  #include <linux/fiemap.h>
>  #include <linux/iomap.h>
>  #include <linux/fserror.h>
> +#include <linux/rcupdate.h>
>  
>  #include "f2fs.h"
>  #include "node.h"
> @@ -43,9 +44,29 @@ struct f2fs_folio_state {
>  
>  struct f2fs_bio {
>  	struct work_struct work;
> +	bool dropbehind;
>  	struct bio bio;
>  };
>  
> +static struct f2fs_bio *to_f2fs_bio(struct bio *bio)
> +{
> +	return container_of(bio, struct f2fs_bio, bio);
> +}
> +
> +/* Keep in sync with the proposed block-layer bio_in_atomic(). */
> +static bool f2fs_bio_in_atomic(void)
> +{
> +#ifdef CONFIG_PREEMPTION
> +	if (rcu_preempt_depth())
> +		return true;
> +#endif
> +#ifndef CONFIG_PREEMPT_COUNT
> +	return true;
> +#else
> +	return !preemptible();
> +#endif
> +}
> +
>  #define	F2FS_BIO_POOL_SIZE	NR_CURSEG_TYPE
>  
>  int __init f2fs_init_bioset(void)
> @@ -426,12 +447,13 @@ static void f2fs_write_end_io(struct bio *bio)
>  
>  	sbi = bio->bi_private;
>  
> -	if (in_atomic() && bio->bi_iter.bi_size > sbi->max_atc_write_bio_size) {
> -		struct work_struct *w;
> +	if ((to_f2fs_bio(bio)->dropbehind && f2fs_bio_in_atomic()) ||
> +	    (in_atomic() &&
> +	     bio->bi_iter.bi_size > sbi->max_atc_write_bio_size)) {
> +		struct work_struct *work = &to_f2fs_bio(bio)->work;
>  
> -		w = &container_of(bio, struct f2fs_bio, bio)->work;
> -		INIT_WORK(w, f2fs_write_end_io_work);
> -		queue_work(sbi->wq, w);
> +		INIT_WORK(work, f2fs_write_end_io_work);
> +		queue_work(sbi->wq, work);
>  	} else {
>  		f2fs_write_end_bio(bio);
>  	}
> @@ -530,6 +552,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
>  	bio = bio_alloc_bioset(bdev, npages,
>  				fio->op | fio->op_flags | f2fs_io_flags(fio),
>  				GFP_NOIO, &f2fs_bioset);
> +	to_f2fs_bio(bio)->dropbehind =
> +			!is_read_io(fio->op) && folio_test_dropbehind(fio->folio);
>  	bio->bi_iter.bi_sector = sector;
>  	if (is_read_io(fio->op)) {
>  		bio->bi_end_io = f2fs_read_end_io;
> @@ -825,6 +849,13 @@ static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
>  	return bio->bi_bdev == f2fs_target_device(sbi, cur_blkaddr, NULL);
>  }
>  
> +static bool f2fs_bio_dropbehind_mergeable(struct bio *bio,
> +					  struct f2fs_io_info *fio)
> +{
> +	return to_f2fs_bio(bio)->dropbehind ==
> +		folio_test_dropbehind(fio->folio);
> +}
> +
>  static bool io_type_is_mergeable(struct f2fs_bio_info *io,
>  						struct f2fs_io_info *fio)
>  {
> @@ -1017,8 +1048,10 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>  
>  	trace_f2fs_submit_folio_bio(data_folio, fio);
>  
> -	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
> -						fio->new_blkaddr))
> +	if (bio &&
> +	    (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
> +				fio->new_blkaddr) ||
> +	     !f2fs_bio_dropbehind_mergeable(bio, fio)))
>  		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
>  alloc_new:
>  	if (!bio) {
> @@ -1118,7 +1151,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
>  			      fio->new_blkaddr) ||
>  	     !f2fs_crypt_mergeable_bio(io->bio, fio_inode(fio),
> -				bio_folio->index, fio)))
> +				bio_folio->index, fio) ||
> +	     !f2fs_bio_dropbehind_mergeable(io->bio, fio)))
>  		__submit_merged_bio(io);
>  alloc_new:
>  	if (io->bio == NULL) {
> -- 
> 2.43.0
> 
---end quoted text---
