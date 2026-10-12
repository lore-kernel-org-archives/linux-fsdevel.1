Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA74499AA;
	Mon, 12 Oct 2026 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793764; cv=none; b=WFXVexMFtW2t+DahRASxaWU2tgPfzb1Oh9XVxxnGiItmmIXRQipKr96SxzWgCkDdUVHilMtNCv+bgSzhCTXyxTlWgsK7JSR6HoEI1VkrEOlCDvxAf7k0Kuc+pAJvnp1/mx9oJm7pDoeqDqD5EX0C8CQx/gx6wX+LmdUG+K77GMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793764; c=relaxed/simple;
	bh=Ggn1QzFwbPVR2NitkrW32ZEbLumGLFJz078XynWfCnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qt9iZK+XUgNKxdqxyNfQDA3PGbbh/LjFPEKB+8HKAFMt9PPHdkCBq20FF7YumB2DyFWotVWjX2ojca8bRZxiAjogGjXhkbGgodxbVjYN9hyi7l1EmRkmUt1U9D744F5Fb0F3wbn1f2kx4dsju6WTMcv9yCPFvrLM8gQroo4nuik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyqnrVBD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyqnrVBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35791F0089B;
	Mon, 12 Oct 2026 08:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791793763;
	bh=Ozf4JuayajorFtuTzG6Sdg0zSsH8Sx228X42Dq5i8ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YyqnrVBDsIXuaIqYITYfLCInNYku6+f8cRH3MWqc7Lkow/YjlkTe135EySZD2QYrB
	 KaEvabyGCW42tZr6Cmg95ITKG0FgwAaqZl5i8cUJ9CkvcnKzHdKsKQrzS9CIixY8ga
	 AONNVew3KdRijq/TEwuSTeH9ehrFo8Bn67Z5lNTfMvnJqryUZ3tlBskeQG5oi9mUDW
	 DxRSIW9MPa7cZyvd6YlwLB8QVvB9JoC5uGvUDgpHVFlWAuj/5hbfBW7vj+GL5HLwsE
	 d+A+QpfIgpwd32WL+lZuwSSeklPEsE26HR7+kkAXByifOlQ31RGOaciGaEE1Ryx+Gb
	 Ef745lyQ08Y0A==
Date: Mon, 12 Oct 2026 10:29:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, lkmm@lists.linux.dev
Subject: Re: [PATCH 2/2] Documentation/litmus-tests: add the mnt_get_count()
 barrier tests
Message-ID: <20261012-holzofen-eiter-filter-f38b426c5d2f@brauner>
References: <20261011-work-mount-fixes-5-v1-0-a9b9a8ecf565@kernel.org>
 <20261011-work-mount-fixes-5-v1-2-a9b9a8ecf565@kernel.org>
 <20261012081409.7590-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012081409.7590-1-parri.andrea@gmail.com>

On Mon, Oct 12, 2026 at 10:14:08AM +0200, Andrea Parri wrote:
> The "exists" clause requires 0:r2=0, so the "r2 != 0" branch is never
> taken in the executions it checks; puts_w stays 0 and the "r3 == r1"
> test in P1 reduces to "r3 == 0".

Right. The lock path is only there so the test looks like the code.

> What remains is SB with smp_mb() on both sides (gets_w and seq), the same
> as tools/memory-model/litmus-tests/SB+fencembonceonces.litmus.  Should the
> tests be cut down to that, with a comment mapping the variables to
> fs/namespace.c, or dropped in favour of citing the existing test?  As
> posted, they look like they check the MNT_DOOMED/MNT_SYNC_UMOUNT handoff
> under mount_lock.

Agreed. We can just drop the patch. I'll just point to
SB+fencembonceonces.litmus with the mapping in the commit message of the
first patch.

Thanks!
