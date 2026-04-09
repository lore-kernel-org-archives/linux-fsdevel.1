Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB802C21F7;
	Thu,  9 Apr 2026 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741721; cv=none; b=ipHFQrKDXQOJF5X9s1FCLn/+Q4S4xQySVf/kCWHk5owm73qls7VVEhjsCSc1ODEYUgPxQzwz4eRarqoZAqTxRcAM0hsvm7v0F/wJSUHqaVvBYoPnqFowWXq5zBFulfrpePQN9N5DhxkkRjxv+rp2nu4aWZuAzWDHoN5ioRfwjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741721; c=relaxed/simple;
	bh=GKEAN9DB9/P4AGv4/8dUvpDZJnM21Fmru/EQhsTNCPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byhC6a2k9hOdFWEsZtCmV/qExiGJTi1A8VPCmhdlEmDwJ1mM9UMyYk/PAYvAPTZp8T+Qy3dmc+UcBJHSt2Au+kt9zBKkkzFzb+nIXKxTf4DYzk6RPu+r7b2zFPztvebt48dWCHqZy1U7HtVTakCUia0mYq5BRqSqdCm+xc65jLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/4ju1IH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/4ju1IH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01A2C4CEF7;
	Thu,  9 Apr 2026 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775741721;
	bh=GKEAN9DB9/P4AGv4/8dUvpDZJnM21Fmru/EQhsTNCPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/4ju1IHsd2JcAXizmP+B+E+F7UMuCkhwb8P2DGvzg7694U3RizH49OHiDPxh0JVp
	 f30s7a6t2t1Vc6rNl/0sdFeh0DjHU3jUenjOSsZX8479jhwG0WeAUckF/0NNfY1eRr
	 KLIgNetiqgAntTwU2+ssV4eX3t7Ok6Tt7gQRnDe6yeVU+KtgEMaYSfrOJPAzi+ARtB
	 ZYcx+xA0ODT6YZHEPyvGeMWDlxGQ4FqZbAvGzvZFIJry8LbkqiLPtDJCI7+onpBaLg
	 yhXYaM1x1zxh1B3bRHtmtX4um3szZYHHyv1KIPgT1/gh80g8xX93wrRMhCoJ29zW+F
	 cxZufHH61TGnA==
Date: Thu, 9 Apr 2026 15:35:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, David Disseldorp <ddiss@suse.de>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 0/6] initramfs: test and improve cpio hex header
 validation
Message-ID: <20260409-vorarbeit-strukturiert-e96484b23484@brauner>
References: <20260331070519.5974-1-ddiss@suse.de>
 <ac0Wd1tmV0ndmE1-@pathway.suse.cz>
 <addn9HXBt8SV9x-D@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <addn9HXBt8SV9x-D@ashevche-desk.local>

> Christian, what route do you prefer?

I'll take it.
