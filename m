Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A34233F39C;
	Fri,  1 May 2026 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777658925; cv=none; b=hdcNYqGL1Lpgt0hGPK7i8ZLzg3DJ9ttZirr+wWXPsHrqMweKeEI+hPpUNTD3axEnFp/w52JRg1c1e5VAVVymoGcyzgoH1gmDhJr013tBwf7lhZal+h31zIq+vKjd0pqlSDlQLAz7NHVYMyWfO0lN7w1D1NQuAmwrjRT6jlmUosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777658925; c=relaxed/simple;
	bh=PqaFfjei5La1XQ0gl4IWe/RM/9kgBaibJ9eibW/HUGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQxvyeGPW7g/36CWh0IV/6HvLY7mgJ/1/fgHxiJTNecPbOb+P9E2ChZwnHk1/QjAQy27yY6RAamqTjmemNNAJfzu2J65ZWpYJfzIZPImrsYiHuBoF2DrR6hWYOrG59kJBdZJWO73/8ss2f1AgO2ANhYAppohYycpjRzYmbPC78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dADRfUu4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dADRfUu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6837C2BCB4;
	Fri,  1 May 2026 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777658923;
	bh=PqaFfjei5La1XQ0gl4IWe/RM/9kgBaibJ9eibW/HUGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dADRfUu4nWYfsLApz6WvmDKT2MAV3lgANwxkYej0wgmUVfvOkZWM5S1txn8M/9UbQ
	 ES5iaQfjoHZP9G18uMav1t+kelbSSjk9x+R/DBU4Rw0A1lxDU4JzRzzt02xG0o/J2r
	 zwJ5FwCFdl1dKQGFD5SACD4LZaiar/QQXqVNSMrMNypd1OtneqO106UZ3VOH9WA0nd
	 HkftZQBxneWxjf0JSHj5nJM+R0a1O3WLNWoqFyabjUHPBBmLcdxDgLV9vzKEjnNn1L
	 FY9WOdjyCRRvaynBkj4lYoNzgD5uBs0uPgSvWD77CoIU3Vgr09cyaoDea5MAjmMOT+
	 ib+lnL1foh+VA==
Date: Fri, 1 May 2026 11:07:25 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Colin Walters <walters@verbum.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	fsverity@lists.linux.dev
Subject: Re: overlayfs: verity validation broken since f77f281b6118
Message-ID: <20260501180725.GB2260@sol>
References: <bf0ba588-002b-4860-848e-e806b193840a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf0ba588-002b-4860-848e-e806b193840a@app.fastmail.com>

[+Cc fsverity@lists.linux.dev]

On Fri, May 01, 2026 at 01:14:54PM -0400, Colin Walters wrote:
> Hi Christoph & Eric,
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f77f281b6118 broke composefs's usage of overlayfs verity=require, this was reported originally in https://github.com/bootc-dev/bootc/issues/2174
> 
> There's some output from an agent run I had in the <details> there, but here's an xfstests patch that passes on without that commit and fails with it.
> 
> From 14231122bfd1e41337e4fb847acbbe038457c32a Mon Sep 17 00:00:00 2001
> From: Colin Walters <walters@verbum.org>
> Date: Fri, 1 May 2026 09:45:58 -0400
> Subject: [PATCH] overlay/118: test fsverity lazy load through metacopy overlay
> 
> Reproduces the regression reported at:
> https://github.com/bootc-dev/bootc/issues/2174
> 
> A recent change in how fsverity state was cached in memory
> I think caused inodes not in cache to appear to have
> missing verity=require for overlayfs.
> 
> This test catches that.
> 
> Generated-by: OpenCode (Claude Sonnet 4.5)
> Signed-off-by: Colin Walters <walters@verbum.org>

Sorry about that.  I guess it's because the semantics of
fsverity_active() changed to be basically the same as IS_VERITY(), and
that broke ovl_ensure_verity_loaded() which does
'!fsverity_active(inode) && IS_VERITY(inode)'.  I guess now it should
do: IS_VERITY(inode) && fsverity_get_info(inode) == NULL.

- Eric
