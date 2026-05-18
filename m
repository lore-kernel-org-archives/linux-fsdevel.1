Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED03EDADA;
	Mon, 18 May 2026 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104702; cv=none; b=ptWmL9a98ja+359us0z+ssy7OSd8CAM+SzHZfguknh+2/V7GUT47SdDsUtPGPe03fKjkCHUJJH+IxEqgAtUFI/jazDtwtsMvjniozvIDC77cS6z9hxQNzWaymr9aes4xFLOC4ZXlY/OQp/gIHO+B5vUbcFW0MCb4cej7GoyulNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104702; c=relaxed/simple;
	bh=KCMsmI7DxcQzs4N8ZHEtNZgXCjWeh6t4flSXexbE6g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWbgCq2W9oIfHTVeEeQjKt6s9zFSt+cQLNZJ7CjsKCyg6pJ4R6iXtO6C7zqydQSXLlPUH6bKUGG1RhU71GOUrc2p4hK8/YbwCM2t/HfQ+Lo+YggZapXPw10VvsIQAvIjLarcoSR85DKsMQKmzbD80ra9+2iaykbZ9HFS50QnpCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYxjPmaU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYxjPmaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0B7C2BCB7;
	Mon, 18 May 2026 11:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104702;
	bh=KCMsmI7DxcQzs4N8ZHEtNZgXCjWeh6t4flSXexbE6g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYxjPmaU4QodPbr2+BG1wxZ3B51ve3CykyM5F/HCQlIkUKNaykQLZASK7R3RQy4CI
	 L8OKUPbPXk3Pea6QlzXFG/bjTQHNNi5lxCmevmPcWwrZtDyLHmcGdrMgqdm+3g0k8N
	 41hJRZY75xgNZu4Skr+A73mEtWu6ztjnKqNoS98ZzuD4G544FKt9Gv1hWE5N/PZThM
	 0zikTVNCOjRuwuXkionRzQDgC7zw6TPn6h6h4ri+jOs6NybC4LmTPTU5BReyDKs+Gr
	 Njx293XQlwk/zAziwHKCa1CDK2aGC0pkdoSIB6IlxjQkzBTjg7zhjUURJvs0kT5E0u
	 okaqRyCOj85lg==
Date: Mon, 18 May 2026 13:44:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Pedro Falcato <pfalcato@suse.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
Message-ID: <20260518-pfoten-rekord-26ceab27c0ce@brauner>
References: <20260516182126.530498-1-pfalcato@suse.de>
 <CAGudoHHeYbPWQbz+vXoS-Oi4PhxX6rh5XsMUkZetyfdnJHNj=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHeYbPWQbz+vXoS-Oi4PhxX6rh5XsMUkZetyfdnJHNj=g@mail.gmail.com>

On Sun, May 17, 2026 at 01:51:16AM +0200, Mateusz Guzik wrote:
> On Sat, May 16, 2026 at 8:21 PM Pedro Falcato <pfalcato@suse.de> wrote:
> >
> > Since the advent of vulns like Dirty Pipe, Dirty Frag, Copy Fail
> > and Fragnasia, splicing a read-only file is fundamentally unsafe.
> >
> > As such, as a mitigation, add a way for users to block splice() for
> > files they cannot write to. This eliminates this whole class of exploits
> > that use splice()+confusion in pipe/net/etc code to gain write-access to
> > files they can only read.
> >
> 
> The patch touches stuff I'm not familiar with, so no comments on that front.
> 
> The core idea is a half-measure which will at best buy few weeks until
> splice bugs dry out and there will be a new attack vector du jour
> which people point their LLMs at. Perhaps it is worth it as a bandaid
> until a more complete solution shows up.
> 
> A full-measure solution would git rm these modules to
> fuck^W^W^W^W^W^Wprevent suspicious modules from being usable by
> unprivileged users to begin with, at least by default. Of the cases I
> had seen so far, your typical machine either does not have the thing
> loaded or in the worst case does not have a legitimate reason to
> expose them. Someone(tm) would have to figure out a sensible setup
> where stuff stops autoloading and there is a whitelist of modules
> allowed on the box, and even then the functionality provided is only
> usable by select people.
> 
> Back in the day I wrote a LSM which learned what kind of socket
> options etc. are being used in a given workload and afterwards only
> allowed that. The code never escaped $workplace, but the idea might be
> a starting point.

Shouldn't be difficult with a bpf lsm tbh. Just so we don't get any
ideas about adding yet more lsms to the kernel...
