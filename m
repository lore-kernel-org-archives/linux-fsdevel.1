Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817804;
	b=g8VBCrkmszjqADGdpdhukIUU3hd85wO+VZNPaOw/EXZ2nrfkK+FArtan9Z4+SX+uQRDp
	 pGPmNoUZrKCwBXZCyAezt9ceMbAn4SOnHcRhFp1jBUvCGn6URnTWQfKpdaARnWafKlk1M
	 sCOuN0e+WT41C6Li1W+mN9W2ka6m1kLAoqkv34AXNGFS+lKvqCEa9VGPBmdaUlwiFHi4n
	 rpbRl5G3W7KV0SRfaiGiAgKpKOGHi8I9/+TJ7Xgtqp/EyP6loOfOmQH8w1LtmFpcMnHPf
	 xLFEiEN/Jm4bSwp8gfFxqYB6YIUc5XJBuTEZ1BB/iWU0tAcRLS6TO1AVynU9K0WsOPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817804;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=lM7eXElareUZrv4evL8lQb9qae8sDLvQgLFXs6Xb2Hs=;
	b=GUIs/Tlbi4rzTTLfbm0t/HjxxhlfsO6qbjVlB/n4pUeOgwbF8qSNiujjyuvFmXLt0KbY
	 OmNpjfcAXJ/m6557S1x2Rj50r917/j0U2os6g7zvCnndM1iEjDrJ5GZsy/ruiCBkF4jF+
	 1zLhkLxE+6FmMTAmqrugdbrmr5SQqaXrLPLN0/pUtW7O076sCZnYnqiLnvktbYLNRJfTA
	 nY+tinfanGd/lfZTUgX2MF9iIDRdXYeIKSoppUz67N85XfcOKJyjag7D7SgBfn4455Z8R
	 Z64UqG5d13PJsmlA7H8BDWhCg7EcewO/YPKwAtw6tuP+Ih2Oojc1EdETMjuyDYR3clg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bsbernd.com;
	spf=pass smtp.mailfrom=bsbernd.com;
	dkim=pass header.d=bsbernd.com header.i=@bsbernd.com header.a=rsa-sha256 header.s=fm1 header.b=WjdiQgG6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qx7SpRYc;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635F4606A32C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 18:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 635F4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bsbernd.com header.i=@bsbernd.com header.a=rsa-sha256 header.s=fm1 header.b=WjdiQgG6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qx7SpRYc
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C371E7A0113
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 13:43:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 04 Nov 2026 13:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793817802;
	 x=1793904202; bh=lM7eXElareUZrv4evL8lQb9qae8sDLvQgLFXs6Xb2Hs=; b=
	WjdiQgG6Bz3OAdfX2Ga2pjl01KSFWjk+0dW4FQSHZSOLJXYi5rFZ4TKqdf9/zLdy
	TUpwB2KrtyzT3F7K5txs1sEJXi2H2oa0lLGFUAnw+co6OgugvxsLVaHLvM+gQt1q
	CbtmZgebKvW5Myq+oZhmRuSO2fXzgDWeBsIbYB3h2UciR1uWLbbxmxSnSFHbou8U
	4CXAyj8DXXfJWmUha3Z9CZRGsVJ4yjHmhBHW5DmE/6hs6HWN/o1L6qaPjvT/ZqF6
	88qNWd2TVcUoAY/qGQHgqZukv7XMYt3q8FLUzkZRmJM6W2WI00L3VdV9YzhCxbnf
	92Wf9fuvx9JZvylrfeqjSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793817802; x=
	1793904202; bh=lM7eXElareUZrv4evL8lQb9qae8sDLvQgLFXs6Xb2Hs=; b=q
	x7SpRYc1+Xp3bRrpBWZdGPZcD6nqO/ahB7p5BWACuPBgYvFiGtpPAA0uVI8VINFE
	ZZOpQwQU3mIkzMDzfHBLA8KBbdhWIMNOmhlHxabFfaPlhz5GKJtVKSlweIRUfFsE
	Y8/zKMtJdpCEA+T5fUE9fumPoyzOEBkOdo0chap3Z61EL+tM0sFlSfPOBcROx/P/
	d4yv9qxmm8tUtf/iaX/JwzcJkk0RCXQLLMGe5Cnu+5UUVEvsC6DBACKwHoL0KraR
	46jtwz9y2owZWtSm0CfFBYmO2MXEHlTWUgU06WLAMRRNsxLpRSwEbF4Ru5bfxrJ7
	vVJXM/vZkEJ6+ATdpvilg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=bsbernd.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793817802; d=bsbernd.com;
	mf=PGJlcm5kQGJzYmVybmQuY29tPg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:RoVLeDrfCcJ7o2tDhUOrZHO2nxUbc3M9SXieXBS2rpStqR2
	MZThchB3EpA3Oh3puUol3WV2XxuC3r0cywnrvJ5WOLs6gQtTPZR4EWilDdwpX4hu
	ouQ1t2sgcRF38pmIK3D0Rpk5W+3pHa0YufKFOzytSculIt0rm2aZoEexvMXhuKjz
	Mr1LIOBz3xEjxzRDB+EXpsugRT8V7TuZ6lQnk0dwmtLcmyo07396hKr2wMGaS5W9
	ZcMhAMe7EjjzKjoio38Nulayvap2iIgMlgYBheHi6hNcKQIS0AGVXU2UzgYQ1/vf
	tUBugUr9aRCOmFRaaIN6E1uM680eXtE88hsfxrg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lxJFfGmODGFLZ67wS5P6yBWPoEsSa25Fq3UBJWvinEY=:Y9BQebpv/IMjiATYb4AqA8czAAQY+rJdiUHCKWgwdN4=;
X-ME-Sender: <xms:yXzrajetyXpKYwwTiZtsuhwmARZG9ocFE_1atoMTvFQrbiBld_cthA>
    <xme:yXzranA4UrO6XykAoPFMFXiZejI9zg7yKmP2nu-sRKqnzLgPVNNxYuGqm2uR_24HV
    RDEjKPT0qy__z9hQwxW4NexWxy1Tf1552JqLGGguX3o6EHGx0MrXA>
X-ME-Received: <xmr:yXzram_dNw0MvkVDk5Eyw7fT1KhYSPc7K0GuPAR6_333D7scEFk6-UMcTISKE9vCXweBG-UKdnGRFylTHQTqPqgKjr2gQePeg3AIZKBuOrdDZf1PIQ>
X-ME-Proxy-Cause: dmFkZTGO61kZ/v+vk5xUZmxQg1ZmbmyzBMkN2oSCMKhvbPKTfzShXhidIqjun7ypzE1Xab
    dlqwcbkah21leuHRT5t2WsW87vc6dtEpCn9tJYn8C4RJlXlChI0CgCJKaO4urvrwsT11V/
    ICQpOn7in2OPEfydIQMhjepIyuQrTKvirISZNbzG01Lwn1SSVAw83wOroYk2BYapsvsmgs
    laa2SEXldCtNup5bSzm7y6GAIjy5NvpI957OK4Wzkx95hUKQUVHyVxUd3d3MZ5D0mxT9x4
    Ec2I/PqVuswryRK8ehAxBdkMUM7AWhxZ2QfrYPwwD6UI1/qROJGe+i62dXCh00HquCtUN6
    MSBTdl8u+9oHzj9QJFBpWSjqpU7mjeM/Wm5HvSvQWB/S8z1SoxlffNefKAe7ot2hXORevz
    NtlF3qjN/+hco9GStck65uOwYWfpjtr+M+wh1n8qCbMV/FqywsvPA08E7UfOeFGOPFUR4M
    NHxFbc1mUDvLwbG07Cdk5AYGIyj5gJtS6IqxYOuksfZTQ8YIsMRdtz1wCxVEkUkIMO8qaC
    s8ZHBwCQD/7/wS10QAR7qGZtrPeSPtTEg0+xGpaQqZUJD5BzWFSxalG0nn30XaZ0mr2I3x
    N+Ktkp0mkyQfM4M7IHW/JPMqrUWz1nM/J8sP/JazOVPe8pyt9epd6mCVji1g
X-ME-Proxy: <xmx:yXzraiJQpYQir8Kk0AZvFD_W1gYP5ln8g60vzv0CD-8PUY6MoDCMxw>
    <xmx:yXzravi9pOO0Y16WEECwIw5m-JbDn-3COxgyLowK1xVFKyI4qtmUxA>
    <xmx:yXzrai6Znju3GHsQx6ehky33RoumbFL0QK_StZQ67xXfBm1TtpT2Sg>
    <xmx:yXzranYfoZ1weYDp_s1NK5shD8frTXwCYbA5Fd1ZRnP9csIzSXhnJQ>
    <xmx:ynzrauC2TTCGjd0Nyyc5lv28WKw59mX1aWBBWjk0OdAJUdxvH5cEDZmf>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 13:43:20 -0500 (EST)
Message-ID: <4fd6eb6a-c115-4f44-bc48-f878716c9552@bsbernd.com>
Date: Wed, 4 Nov 2026 19:43:19 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] fuse: auto_inval_data drops a write-through write's folio
 before its WRITE is answered, and a read caches the old bytes
To: Geoffrey HARTZ <geoffrey.hartz@gehtz.com>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: "fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <PAPP264MB7189832597866399467B911689682@PAPP264MB7189.FRAP264.PROD.OUTLOOK.COM>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <PAPP264MB7189832597866399467B911689682@PAPP264MB7189.FRAP264.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/26 17:50, Geoffrey HARTZ wrote:
> Hello,
> 
> On a FUSE mount with FOPEN_KEEP_CACHE, without writeback_cache, and with
> FUSE_AUTO_INVAL_DATA (libfuse's default), an in-place write(2) can leave the

https://github.com/libfuse/libfuse/commit/b3f0fac436931223bf67f4484e8fede2ab2eecef

which references

https://lore.kernel.org/r/20251009110623.3115511-1-giveme.gulu@gmail.com


Thanks,
Bernd

> page cache holding the bytes from before the write. Reads keep returning the
> old bytes after write(2) returned and after the server stored the new ones.
> In our case SQLite in WAL mode read back stale WAL frames, and a checkpoint
> copied one of them over page 1 of a database (Plex's library).
> 
> Reproduced on vanilla 7.4-rc1 (not tainted, in a KVM guest), on Debian's
> 6.12.111 and on 7.2.11. The code involved is the same in 6.18.
> 
> The sequence:
> 
> 1. Thread A calls write(2) over cached pages. fuse_perform_write() calls
>    fuse_fill_write_pages(), which copies the data into the folios. Folios
>    that are uptodate are unlocked right away ("if (folio_test_uptodate(folio))
>    folio_unlock(folio)"). fuse_send_write_pages() then sends FUSE_WRITE and
>    waits for the answer. FUSE_I_SIZE_UNSTABLE is set only for a write that
>    extends the file.
> 
> 2. Thread B calls read(2). With auto_inval_data, fuse_cache_read_iter() calls
>    fuse_update_attributes() on every read, and the attributes are stale
>    since the previous write's answer. The FUSE_GETATTR answer has a new
>    mtime: the server moved it, for example at an fsync of earlier writes.
>    In fuse_change_attributes_i(), fi->attr_version has not moved yet (A's
>    answer has not come), so the answer is applied. The mtime differs, so
>    invalidate_inode_pages2() runs. It removes the folio A just filled: the
>    folio is unlocked and clean, and A's reference does not keep it in the
>    mapping.
> 
> 3. B's read finds no folio and sends FUSE_READ. The server has not applied
>    A's WRITE yet, so it returns the old bytes, and they are cached.
> 
> 4. A's WRITE is answered. Nothing drops the stale folio again: the mtime
>    does not move until the server's next change, so every read until then
>    returns the old bytes. This includes A reading back what it wrote.
> 
> writeback_cache avoids it (the folios are dirty, not invalidated). Without
> auto_inval_data, only a size change invalidates, and with
> explicit_inval_data only truncate_pagecache() runs.
> 
> Reproducer: a small go-fuse server with one 1 MiB file. It applies each
> WRITE 3 ms after it arrives, and moves the mtime every 20 ms when writes
> have landed since (a periodic sync, as our server does). Writers rewrite
> 1048-byte records in place and read each one back after write(2) returns;
> readers read the file in a loop. On vanilla 7.4-rc1 (16 vCPUs), in 15 s,
> 441 to 461 of about 4,440 read-backs returned the previous record, in each
> of 3 runs. With auto_inval_data off: 0 in 3 runs. SQLite in WAL mode
> (1 writer, 3 readers) over a loopback server built the same way (WRITEs
> held 3 ms, the mtime moved at fsync, close, setattr or every 30 s): 2 of 3
> runs failed within 9 s ("database disk image is malformed", "file is not a
> database"); with auto_inval_data off, 3 of 3 runs were clean. I can send
> the reproducer.
> 
> Possible fixes:
> 
> - Keep every folio of a write-through write locked until its FUSE_WRITE is
>   answered, as is already done for a last folio that is not uptodate
>   (ia->write.folio_locked). invalidate_inode_pages2() then waits for the
>   write.
> - Or make fuse_change_attributes_i() discard an answer (as it does under
>   FUSE_I_SIZE_UNSTABLE) while a write-through write is in flight on the
>   inode, not only one that extends it.
> 
> Our workaround in the server: turn auto_inval_data off, set
> explicit_inval_data, and invalidate a file's pages ourselves
> (FUSE_NOTIFY_INVAL_INODE, or an open without FOPEN_KEEP_CACHE) only when no
> write open of the file exists on the mount.
> 
> Thanks,
> Geoffrey Hartz

