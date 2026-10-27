Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072142;
	b=xl/OS3f9Thdvt5ZbA8zDwaGhE/1DqBCPgNnYi+I6TdTw8QIZirw+E3o+0wcxBEaP15se
	 FGhFxGSIUUvfnUuOHX4yfSA3nfoGjZVtS0C5bDTOUwoSBIwqofdIOW2jtQ+hzMkFjTMxj
	 BiUXISU9KQatxaU9hR8sOjTbyHKA9Ah0qXeafLM/83ddXw7iioIMfUCGS4gksICNUN+AD
	 SEteS6fw4munbvZcaIAmwZJvQPymmt3nmEL+AUZd/k3vdSyTwtov//gwQtom/etENG9h9
	 u6mNdMEBlZvE+lklzGRaTtBbVqRuaF3rAHabT68pjf28HzRPzaBYdxjOjJJu67rlNbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072142;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=tvYV4llUeul3tyzCuFCTWNoZ4MPP4Sa+bqacHF411BE=;
	b=t1yahiAs0UwWOvWhFhnDYvlN4xfNhtjG7FIYc4LyAFpa8oQnO/n+31Awe0/h71X/JZpD
	 OFo0gAH0V2a1tzf8+tbPPn4sGVjPk2DzyxXpHYWjc7QBoZ3WsQDthT+8hT80rbbbtpXSP
	 YW/26JhlOVVAlI9hstBttYI+iSqF1D6UWKa/10ez2o/9++SILNgmH6gRl66CFgvzVxO/J
	 V/C+KEk33lLZ9nM+VLOwZclbnKGUxwZZOkt9W6RNBf8/Tck0PKpp5O/zTQrU+DmoB7FEB
	 h+pdrt93UL7443ow2kkwFcHzS3YatvXcz/6APWb6ALmVqyL+sHnMBkXlAAYBeISPHiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=XdNdgcie;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=le67u1ay;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B02606A31D;
	Tue, 27 Oct 2026 03:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6B02606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=XdNdgcie;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=le67u1ay
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 47117209655A;
	Tue, 27 Oct 2026 12:35:39 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1793072139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tvYV4llUeul3tyzCuFCTWNoZ4MPP4Sa+bqacHF411BE=;
	b=XdNdgcieu/SQm6nAWpPeszA9rYPdH06UplQw+AilYjKl6jG1xzXxlvW6ay8kAK9E15z95L
	TYljM8bgc5fFkBF0DEiCQpKUCoatqmnUYPbK0vUBEJFNB5COHqxAT1OZExyhSEVPEFxqaY
	dg2IwyDvTXxEblafMRarfPvzBKvM4HniVLqdeEkqsvBNxXm5LvXcm9cqbw0VMMn1GjlTsz
	ofL1AJPjIlaidvcWYGexdoe6CSrAn2KMCdNuIDnkdt45GBjXeCEgHMReKwDD0qihPDaPf7
	wdMyV4aks39/sP11NmMNNKYKTJth6magKxoYyI7BD+SR697rqnoowdwJ8DTAEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1793072139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tvYV4llUeul3tyzCuFCTWNoZ4MPP4Sa+bqacHF411BE=;
	b=le67u1aytl5A/bgRr7MFO7GWkHUvL94h6WUcByCFPY9DP/hdBQopLkxqXDf0viVXrQpUia
	rVlu0dAZ0cPCxwCw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id C5CF7E004F7;
	Tue, 27 Oct 2026 12:35:38 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id B956022001D3; Tue, 27 Oct 2026 12:35:38 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fat: improve fat_sync_bhs() write submission
In-Reply-To: <20261026163941.495833-3-matheus.aalmeida@inf.ufrgs.br>
References: <20261026163941.495833-1-matheus.aalmeida@inf.ufrgs.br>
	<20261026163941.495833-3-matheus.aalmeida@inf.ufrgs.br>
Date: Tue, 27 Oct 2026 12:35:38 +0900
Message-ID: <87zevzbyt1.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> fat_sync_bhs() does many individual write_dirty_buffer() calls without
> plugging, making batching in the block layer more difficult. It also
> does not pass the REQ_SYNC hint for these synchronous writes.
>
> Use a plug around the writes so the block layer can more easily batch
> them. Pass the REQ_SYNC hint to write_dirty_buffer().
>
> Benchmarking was done under QEMU/KVM with a virtio-blk device using
> cache=directsync. Each result is the arithmetic mean of 10 samples.
>
> start = now_ns();
> for (unsigned i = 0; i < count; i++) {
>     fallocate(fds[i], FALLOC_FL_KEEP_SIZE, 0, bytes);
> }
> elapsed = now_ns() - start;
>
> Sync-mounted FAT32 using count=16 files:
> File size    Cluster size    Before    After    Improvement
> 256MiB       512B            13.11s    11.87s   1.10x
> 256MiB       4096B           1.657s    1.469s   1.13x
>
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> ---
>  fs/fat/misc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index b6a9e2e122cd..e8e2f13254d5 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -9,6 +9,7 @@
>  
>  #include "fat.h"
>  #include <linux/iversion.h>
> +#include <linux/blk_plug.h>
>  
>  /*
>   * fat_fs_error reports a file system problem that might indicate fa data
> @@ -354,9 +355,14 @@ EXPORT_SYMBOL_GPL(fat_update_time);
>  int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
>  {
>  	int i, err = 0;
> +	struct blk_plug plug;
> +
> +	blk_start_plug(&plug);
>  
>  	for (i = 0; i < nr_bhs; i++)
> -		write_dirty_buffer(bhs[i], 0);
> +		write_dirty_buffer(bhs[i], REQ_SYNC);
> +
> +	blk_finish_plug(&plug);
>  
>  	for (i = 0; i < nr_bhs; i++) {
>  		wait_on_buffer(bhs[i]);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
