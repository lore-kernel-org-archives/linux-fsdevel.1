Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FEC37883D;
	Fri,  3 Jul 2026 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073997; cv=none; b=CR0Uw8NNtwGugwhD0ImnC1Vi+Ao89E17xBZtwa8ZfZJ3P2sIQJFjk8FS6lAHw891S+Ql73ccqDFzeqSwG9GXGh0dIbudSfbLGza85qrzKRrVGdTvFzCb6L/QOnT8Rg72IfdS5aMj/XJ3/LNUS8l/MZrcz73oYOc0ZL97J+6qzzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073997; c=relaxed/simple;
	bh=QkiATXld3lyhEheGjSMWfj8L2+fCYz5ZiStZfWTGZUM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=KYfV5KBe5zgbjTHKsiP7HkqXyvL78neTdwt03Z2UoLeqZm3F+gpC9610DbKBps39AY/PI28HsjmM1KL9VexmhLYXCqyHtaVFIQGAce/btrTOMgHnBPll3ZkKA/LNlyw9trT+iow9XucWJXsCFAd/WWRdxxOSy7e6yWCvRdB48iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOHPi6rb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOHPi6rb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8A41F000E9;
	Fri,  3 Jul 2026 10:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783073995;
	bh=75piOD1kjbKyc2rjDDeSKr4ySgkmI+tNdp7VVYdPp0E=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=QOHPi6rb8DaX76VnfT/ah/oDzHWq+KAqdukLVycb+096TV7FKIBzOvhvdumrUptQ7
	 xLGlZMb3nQ5kLqYHuY/fQrN1BdfcyIwS9Uhh+ZJ+QwsY1mssCLQlM5AJWVS2fKdtGm
	 litdDjgrinpqZli0IJ6bIGltqD+gY/YkZQ9+tG+/XDVZrXJSOV+zn2L6hXPALSubX9
	 yCo6/eeilJzdNbw9/ei5Ca9xPuBhwDYqVX9f93sQUHyNG045WGVeecYXo9vBFTkInD
	 i6BruXcM6Pg/V6Gww5lfqTGon2qR4PE8KmTYFfNzymmdNdGd6nq5a04KJFvrPmuIng
	 uiSLBH/W2uBSA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RFC 0/4] fs/pipe: unify the page pools into a single
 per-pipe pool
From: Christian Brauner <brauner@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, oleg@redhat.com, mjguzik@gmail.com, 
 josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org, 
 axboe@kernel.dk, shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com
In-Reply-To: <20260626-b4-pipe-unification-v1-0-d23fa6b1ee27@debian.org>
References: <20260626-b4-pipe-unification-v1-0-d23fa6b1ee27@debian.org>
Date: Fri, 03 Jul 2026 12:19:50 +0200
Message-Id: <20260703-dutzend-endabrechnung-mensaessen-1e020014ecba@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=621; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QkiATXld3lyhEheGjSMWfj8L2+fCYz5ZiStZfWTGZUM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS595xIOnRFPOvhobnnk4xcpyztE8tzWj9jv8mWjj+zX
 5wU+Wzt3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARlTWMDO2dByVeL9l9oHL7
 bRah5JLLPfGigrWx995e5b1W9DKi/jvDP/OA9yFtMfKGW5qrzRe4rpJ1nrvMUfHk8dlvFX/OFW0
 V5wIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-06-26 03:26 -0700, Breno Leitao wrote:
> TL;DR: This simplifies the pipe code, unify the page pools, reduce the
> code by 11 lines, and improves the microbenchmark by up to 23% — so it's
> probably wrong (!?).
> 
> Summary:
> =======
> 
> I've spent some time converging tmp_page[] and the on-stack
> anon_pipe_prealloc pool of pages into a single per-pipe pool, as
> discussed previously in a few places, most recently at:
> 
> https://lore.kernel.org/all/ajLA_zxsYyKISkwp@redhat.com/

I think this makes sense. Sashiko has some comments on missing trim for
readers you might want to consider.

