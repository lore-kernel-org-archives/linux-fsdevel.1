Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191753;
	b=ABBW0HVqitHX0nsiZPIDBLNmmhs2mYbLsIWpIQiIkMyCnOIDay9EOyTCuZPvnTmblFWa
	 hE0+BUEGMUcM5PklizYtD+sPRTpUeqlL81GOHj0lBCdvmYyk9UUI1frtD2wTp3K4JmNyf
	 h8WsLfoLsc1oZ/M5iYHfkiDAjKasK2H+K6nsI89DVVsDrzGruAf5Yirus+kpIiPPYu8Su
	 Kj9CDpdA4e29JylaW8Tr9zZpG/6Qz60ATD+6D7gdivQOhOVzQVKTQKM4O53+GKpPLcBWx
	 qDTybOsCcZ2zXWjMwMOPeTwsUO6z+QZswhUrthEnPvLIO8AFS+y9IVklpqI/HuO4OoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191753;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=vFrxkYlbffnn1oFL/jywinkH4FaLHpHlb6I6Aq54CHs=;
	b=vPTDUvA2vPIQADoCzcXkbtGbbctqJjlHT/ZlOu8BSWwc2LMeFbY9/X5vXZc23T2KLg8s
	 8uRPejIHSZ7KttgIS3PuSmh9XU8Hc6gtCdNupZ0ElXEi8112cRtXnUpfDFYvMKyd5SuMd
	 mvKe8Uv4IRTssXY1ObGIDDSHAjHcdtWyl+qOtZqD0mVYcillvWMY3YsJIUNsCMGtyn42s
	 b9zELBj1EtInb3AJzBvtccx1kEmyTx8XrD00aat1vkn98v3JG+Tms9NqS5bmtn4gZ1WAf
	 OFVNBPY9dp2sJClOMVOQOt+34wnMrBjmILUFpEP6iAHp7N61FwOK3K6Hm3Nmndl2/Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AGkQ0ZcJ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E9606A32A
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 16:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 274E9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AGkQ0ZcJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795191752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vFrxkYlbffnn1oFL/jywinkH4FaLHpHlb6I6Aq54CHs=;
	b=AGkQ0ZcJd1poWuLV6SEXHqiEhEz64Q48Wh6pjrn/P7QRT4DXYnFqgAJwrdrSG44ef1K7fm
	A3j1LRi3veHxByBUvf0TlCONFOHTfranabYfV12l9NOZeZ9smgJ5wfqZhRh9HGxEaBccQD
	BoPGtHSbUbyK3gK6LbAY61WMqMZuPX8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-wX-z_3wnP92GD2JkyzEneQ-1; Fri,
 20 Nov 2026 16:22:28 +0000
X-MC-Unique: wX-z_3wnP92GD2JkyzEneQ-1
X-Mimecast-MFC-AGG-ID: wX-z_3wnP92GD2JkyzEneQ_1795191746
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B49221955F08;
	Fri, 20 Nov 2026 16:22:25 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1960B1956049;
	Fri, 20 Nov 2026 16:22:22 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Fri, 20 Nov 2026 17:22:25 +0100 (CET)
Date: Fri, 20 Nov 2026 17:22:21 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jiwoo Kim <arpe1618@gmail.com>, Chen Linxuan <me@black-desk.cn>,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/3] pidfd: use one helper for pid namespace visibility
 checks
Message-ID: <awBzvXKHePLzjABf@redhat.com>
References: <20261120-work-pidfd-pidns_visible-v1-0-0e82d08469ae@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-work-pidfd-pidns_visible-v1-0-0e82d08469ae@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/20, Christian Brauner wrote:
>
> Christian Brauner (3):
>       pid: move pid_in_current_pidns() into kernel/pid.c
>       pidfd: convert remaining visibility checks to pid_in_current_pidns()
>       pidfd: restrict pidfd_get_task() to the caller's pid namespace
>
>  fs/pidfs.c          | 12 +-----------
>  include/linux/pid.h |  1 +
>  kernel/pid.c        | 31 +++++++++++++++++++++++++++++--
>  kernel/signal.c     | 23 +----------------------
>  4 files changed, 32 insertions(+), 35 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

