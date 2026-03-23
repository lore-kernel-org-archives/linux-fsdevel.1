Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8941336B076;
	Mon, 23 Mar 2026 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303674; cv=none; b=GNACWuGSW9HGohljUloR0HAi/JMwemsN5Y7z1G4TT677EdbdLw85ZjSdfJMRy1CE5feUxV1rSp+JfYnh2LT2FFx2bT7wnrF2n6yNekBz/dxKOrbiEh+2P4JPRiczFZHyFdVVtnSl829Uidil/2taenLmIK9Yo84yowTyLP6HPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303674; c=relaxed/simple;
	bh=a5lBmtEDMEKsbXHprIG15+gNjcC1Ou9FndAY6s8IN38=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jzqh5+Ox4b39nbKobfuumSm/OGDKKb5NbWUsaZYYscDTogjr4qqo4IQ0prVKtIyjmqaTiOHXquMIFBEb6RBLtrVwcHFk0OC42K56tAor7PTYbv6zC7Br/TstQHeBGo/0wViP/ZKC4QadMXnVqWOTHMCe2d2UHYjhYTKWlU2eAPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JtwuHc4R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JtwuHc4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE125C4CEF7;
	Mon, 23 Mar 2026 22:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774303674;
	bh=a5lBmtEDMEKsbXHprIG15+gNjcC1Ou9FndAY6s8IN38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JtwuHc4R9O8YrrYOFFJ0IZewrAkPTiaWTrEOy0c/zp2bf1gPC7weg5BM9S2qEMEsC
	 adMEkJzmuvZNf10s/af6kiEkMLDpMP9J30JWirTJ+OU9QkH6kCM7yDQ//gAtJrCs0F
	 v6EGoX7cKg58yLPJfqvDgjUaFnEPyybVtbI7U/vY=
Date: Mon, 23 Mar 2026 15:07:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Disseldorp <ddiss@suse.de>, Petr Mladek <pmladek@suse.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 0/6] initramfs: test and improve cpio hex header
 validation
Message-Id: <20260323150753.1937b34b80772602d634d180@linux-foundation.org>
In-Reply-To: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
References: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 15:54:16 +0100 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The series that introduced simple_strntoul() had passed into kernel
> without proper review and hence reinvented a wheel that's not needed.
> Here is the refactoring to show that. It can go via PRINTK or VFS
> tree.
> 
> I have tested this on x86, but I believe the same result will be
> on big-endian CPUs (I deduced that from how strtox() works).

AI review asked a few questions:

	https://sashiko.dev/#/patchset/20260323150054.3587083-1-andriy.shevchenko@linux.intel.com

The "Is it possible for kzalloc() to fail and return NULL here?" one
should be ignored - I've asked Roman&Chris to teach the reviewbot that
unchecked allocations in __init code are OK.

