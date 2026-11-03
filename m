Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667587;
	b=Te+T2qrW5xpYNnGZ2Vhf5kZf7cN4zoFklXa//W0Gio6cZsZCKMp0u6NvrZeedUpOgsHV
	 fzrC0ymc35x5iLqVeb4WZKlw7PPj5xNVNBfSLGCddUXcZEtULwJjd3lobvwoqxrbo9PxD
	 NV7uLXi0AbvAxggzh4dva1LS72b4yvQOHvu3b0aE7Mt1bSqGDLygQCFYC+jn2yv6yfw1M
	 ay2SxqYU4ffaTlOls3B2rjnFr6RWo0GigzYfo8jOf0LOF6mTNIHrqLL34uw8ehJNtSM7P
	 R/7CVd5EFpauXCNMjr/04aKvaQtelAw6Ps+WDwqO2gDAvLzh1CchbZl7RPBjiAThnNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667587;
	h=DMARC-Filter:Received:Received:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Rspamd-Server:X-Session-Marker:
	 X-Session-ID:X-HE-Tag:X-HE-Meta;
	bh=G6Rv/71RK5koHmtnnOxQb3SYVS/u069P90N9ZnE91N0=;
	b=5SSVBbew+TcBdRZWNlGCMphBXuHpzn5la22QLXPvRVxD2/Zyzn1bO63Uko5R5ediwrXJ
	 F/cxqBqdtYR4nNxMNja2hQE1+HbXTLaOrJHOHMVGVY8ii+haw+jAJ4su9WVBRQt5wLg5N
	 YKKllvF8iXBDOVcubY+OTLBNC2qIDxjpl5lM0x1zQ0J1wv2WalbDlUbCfkKoMrbLzXxVg
	 mNLuIYi9on3MaSaQ7gc0uqFjB4uJWttFXwQce0cdiMshr9dbtDeFJ/XXt/d5BlYyewDFL
	 MQGSW2VzmB0GyZiiJNuYZb73AA0enZDL/rQQ9bQRoi8SwFYyulrITgNrFTfQ8Hf8BXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=groves.net;
	spf=pass smtp.mailfrom=groves.net;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7FC606A324;
	Tue,  3 Nov 2026 00:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C7FC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 5BB8C1401C1;
	Tue,  3 Nov 2026 00:59:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf04.hostedemail.com (Postfix) with ESMTPA id 6F79420024;
	Tue,  3 Nov 2026 00:59:37 +0000 (UTC)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id ED3CEF40066;
	Mon,  2 Nov 2026 19:59:36 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-09.internal (MEProxy); Mon, 02 Nov 2026 19:59:36 -0500
X-ME-Sender: <xms:-DHpahttLsgo-O9LyRnTMyYg8OOCyrR3pmllmRf0Hq0xoUpxc8-65A>
    <xme:-DHpalSKPczzavif0J17t-PbwkXHInKEhMsWhL6255WyOgK8Edcwgivkew44VEd51
    n_aZvX2apjg4HaEot2YixfEXRDNTh7cFqfa_vBXg71MXgo4-KCYVV2R>
X-ME-Proxy-Cause: dmFkZTG4ZL5up0UnMPo6b6IWOllL5Oy/VFhuJdZlan9+353xhOnGA4qXvG4k7Wquz+vOiW
    LJnk4kJCnIgTcfnHpFSpI1rJQL8749tASHR5iZ2a0kCIBoJcM0W0LOfofsp6qtawBEF0By
    OtljbVcCImpCgBZtGS/cgexFW/DNAncaQyrQHcw7ZQuqMvFH8Mo8L9j7Ei5Uq2k5QPQ0lG
    G0nBf9gwdZxGPFSoTOZQ8heirm6tt4T/vi0NwC8IYqyzo8M4CpF/sfHYRAPcYRT9AiWYyB
    bnqqTM3tqttT9xNtdZDjumisqXV9aItq2O+VPJNgxG7MjmDMtgJFncjMXP/jUIfo84vsZP
    Sujev+lKEf1h6ZIeAmnw7/E3zBJM26AMnc7vrLeJs+EmkI8ZC01uFU4q47FRdQHUzsCIFJ
    ayGr0+bZLowvNL4rMRF/qz2JRRjLi2cN8nKlFV2vtyXr7Jdj7Vm6aGTnM9O/A9SIAFpFQU
    U/K1tRUIeqb1GMWF36zDadocI/88N9kEgnyYPfASVPARu4idUzIKgKWuZPv0GcQG+qs0An
    ImOK5x1QGy0adLvz4pB0l2S921cPf6ZpMoXE6BaAglTWn+AEER3Szx0uFrol1BTgibErlj
    33sE7NWPC3gyytLTjSTw8ef4TvlDHHJ1RRWnpCohsoXrHzo1QaNjbsi6pszQ
X-ME-Proxy: <xmx:-DHpajQUV2WJTQZXgfypECLGJ6AcoJlARUNwPPm4PfIEC1Y4rzxaWg>
    <xmx:-DHpanBW-Bg9tMfcv_h_tl65ko8AuR0SV65UacSvANVYkVy18iWa_w>
    <xmx:-DHparFJ6Xn5B8w3_WppmLMpi3cQJLB3-qu9wBricBlFxRfNNX-iYA>
    <xmx:-DHpapDUZHzuy9YULnLuxGh9SBJBW_zjpR_Xy_NJbRt0RzXxQvTgQQ>
    <xmx:-DHparW1XKrqfvlDUZFWEdJsaCSdo-Tlqr4fQIl_KU7jkwohifDElM0l>
Feedback-ID: i3a164872:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C2A75700065; Mon,  2 Nov 2026 19:59:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 02 Nov 2026 18:59:16 -0600
From: "John Groves" <john@groves.net>
To: "Joas Antonio dos Santos" <joasantonio108@gmail.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>
Cc: "Miklos Szeredi" <mszeredi@redhat.com>,
 "fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <069bdfb7-2bad-47d4-ae43-d3d50a63b816@app.fastmail.com>
In-Reply-To: <179346145958.61208.701521796030924197@gmail.com>
References: <179346145958.61208.701521796030924197@gmail.com>
Subject: Re: [PATCH] fuse: refuse FUSE_NOTIFY_STORE for DAX inodes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6F79420024
X-Stat-Signature: jxfrrcn9qtzxrk9pqk51438wr5rmo4gp
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX1+uPrMiW9M2xl4Azk1RV1LatNDq3wjJW4w=
X-HE-Tag: 1793667577-708489
X-HE-Meta: U2FsdGVkX1/enDX7YLiwcBSjp9OFMJrxcBhxOcz90MsEsrBlp5pHm5UBECEjDQOOixxzTThtBc7YfznDf8VITttnWHsqlhKEz9lCz4/bcnOmorqqr0ezh+bD7G0a9HlflCsbEygTjwJB/vrQZzGSLQfAPJiXnyHszYumd3UVp3tcZRtfmh5TBTzEsH271+1UzdJdhyVvo95knKxEjYImAoobD0OTgmCc0yYIXcQ4y6vIfXmL62vUqul7C3m7gM9SSa2iqqOxQLvBRw0/oWDpx6DZt1sjpmiZAm4gv5z9MUAmr2uUNmX5KT6mgduLM6zedI4z5qtHBUbkcYfFiSgoR0lqL4VZf5+ipDVnapKBNr7GJRBvOHlh8+M1X7RVgZ9MxUOyFPtF+tYh1v+vTvXfLg==



On Sat, Oct 31, 2026, at 10:44 AM, Joas Antonio dos Santos wrote:
> Since commit 2fbe4586cff3 ("fuse: add support for opening dax device as
> backing"), a regular file is marked S_DAX whenever the server sets
> FUSE_ATTR_DAX in the attributes. This does not depend on any INIT flag,
> so any FUSE server can do it, including an unprivileged one.
> 
> fuse_notify_store() does not check for this. It adds ordinary page cache
> folios to the mapping of such an inode with filemap_grab_folio(), while
> the DAX code expects that mapping to hold only DAX entries. When the
> inode is evicted, fuse_evict_inode() calls dax_break_layout_final(), and
> dax_layout_busy_page_range() hits WARN_ON_ONCE(!xa_is_value(entry)):
> 
>   WARNING: fs/dax.c:825 at dax_layout_busy_page_range+0x394/0x4dc
>   CPU: 0 UID: 65534 PID: 93 Comm: fusedax
>   Call trace:
>    dax_layout_busy_page_range+0x394/0x4dc (P)
>    dax_break_layout_final+0x104/0x278
>    fuse_evict_inode+0x2cc/0x57c
>    evict+0x2b4/0x748
>    iput.part.0+0x51c/0x964
>    ...
>    fuse_kill_sb_anon+0x170/0x268
>    deactivate_locked_super+0x98/0x11c
> 
> With panic_on_warn set, this lets an unprivileged FUSE server panic the
> machine.
> 
> DAX mappings do not hold page cache folios, so storing data into one has
> no use. Return -EINVAL, as is already done for files that are not
> regular. This also covers virtiofs DAX inodes.
> 
> Reproduced on current mainline (arm64, CONFIG_FS_DAX=y) with a FUSE
> server running as uid 65534 in a new user and mount namespace, answering
> INIT with no flags, LOOKUP with FUSE_ATTR_DAX on a regular file, then
> sending FUSE_NOTIFY_STORE for it and unmounting. Before: the WARN above,
> and a panic with panic_on_warn=1. After: FUSE_NOTIFY_STORE fails with
> EINVAL and nothing is logged. FUSE_NOTIFY_STORE on a regular inode
> without FUSE_ATTR_DAX still works.
> 
> Found by code review of the DAX backing changes and confirmed with the
> reproducer above.
> 
> Fixes: 2fbe4586cff3 ("fuse: add support for opening dax device as backing")
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>

LGTM

Reviewed-by: John Groves <john@groves.net>

> ---
> Tool-use note: the code review that found this and the reproducer were
> prepared with help from an LLM-based assistant; I reviewed the change
> and built and ran the tests myself. Reproducer available on request.
> 
> fs/fuse/notify.c | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/fs/fuse/notify.c b/fs/fuse/notify.c
> index 984e4945e..938440474 100644
> --- a/fs/fuse/notify.c
> +++ b/fs/fuse/notify.c
> @@ -167,6 +167,11 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
> err = -EINVAL;
> goto out_iput;
> }
> + /* DAX mappings do not hold page cache folios */
> + if (IS_DAX(inode)) {
> + err = -EINVAL;
> + goto out_iput;
> + }
>  
> mapping = inode->i_mapping;
> file_size = i_size_read(inode);
> -- 
> 2.43.0
> 
> 
