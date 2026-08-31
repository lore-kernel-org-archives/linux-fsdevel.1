Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDAA31B101
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200669; cv=none; b=nOQP/SkkXzVP566KM6JRYuaWhPfBjSfMIuOQr2rrG7hrx7RCG2FEXztt09YNo59kwOs0yy+D9YhARNb+CeP6ozDE/JZA9OcwgT7yHo8Ln9rFS8BKWSNFIdLA8A1koOescv09FHfqsYnAmN9JusR/f3rT+V6bHy+cRyPWyfMsywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200669; c=relaxed/simple;
	bh=u/O8U4/wbfjjJlI+bVE39fAH1Few86fKyT5XoAx2L54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqzgbYOCbHqPKX6lhMQh4DUre47/lONZWIe7MJmohAXQnzgF0OawNLK53Mv0RupSusB4c9oAe5WG8+h5OQBdvuq+zeQvUIe52bL1rNs9BAyhiqRoCKpRI7IBaUPUx37u8pVWCux+lcCivwIPhmwa8yI4odwaDVsDtb3cts0oEKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuH952As; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuH952As"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788200667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u/O8U4/wbfjjJlI+bVE39fAH1Few86fKyT5XoAx2L54=;
	b=MuH952AsodJKxI30Qt/KmKnQ2c2XwkGUjTlddwIxKys3E1QPMCa0AHWMeLN1ua0z0FpLfy
	rYfVmmtLFH1oEPkrBxBh8IqTIgpUi8hvJqWgt7Ds+acZGJl6gqujnxXWdnGxNwEALxNSAS
	05yZFgOUCcAl2O4T1ibsNj0cV+bcBzE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-6LkvmBIlPU22cg6vsRZfyg-1; Mon,
 31 Aug 2026 14:24:21 -0400
X-MC-Unique: 6LkvmBIlPU22cg6vsRZfyg-1
X-Mimecast-MFC-AGG-ID: 6LkvmBIlPU22cg6vsRZfyg_1788200660
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F7A1195419A;
	Mon, 31 Aug 2026 18:24:19 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A08D618005AA;
	Mon, 31 Aug 2026 18:24:14 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 31 Aug 2026 20:24:19 +0200 (CEST)
Date: Mon, 31 Aug 2026 20:24:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] posix-cpu-timers: Dequeue per-thread timers before
 exchange_tids()
Message-ID: <apXGzcA9BmrbrQZv@redhat.com>
References: <ao7Q8miiuLAPVnWv@v4bel>
 <ao7iQ_wOLghOvTsq@redhat.com>
 <875x0qclcx.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x0qclcx.ffs@fw13>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/31, Thomas Gleixner wrote:
>
> On Wed, Aug 26 2026 at 14:55, Oleg Nesterov wrote:
> > Can we move posix_cpu_timers_exit() or the whole CONFIG_POSIX_TIMERS
> > sequence in begin_new_exec() up, right after de_thread() before the
> > "if (retval)" check?
>
> Yes, but that does not buy us anything.

Hmm. I don't understand but this doesn't matter.

I didn't mean this makes sense, I just tried to understand the Hyunwoo's
fix, in particular the placement of additional posix_cpu_timers_exit().

Oleg.

