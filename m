Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55870335567
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770812002; cv=none; b=tU0DDgLPqDwRied2UV8aWeP1JEkGCUrNlzc4ot79Hl3Am9PPP6GvouhWyGOrKWrOpIp5pEnwvluGn0cdxACK0CdA0r3Z5/bbhXvMLeDReksd7viejsYCcUl4sg94+duxnoHpmnPSp2a07cAm338gzH0gRgFQHxFORNoqiMfdpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770812002; c=relaxed/simple;
	bh=GsgSVk0yQMNeMELSV7tddgM3enuVuEwnc/fX1tIfwvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JidvljcX4hYVEvzIVOG5weKR8K/1kKq5Y+FdT3jP00gefO6tEgni1307I3808xo8Pa/aaPZ5T0rX/jynKWAydq4B/35j7orCtTitORzxlpu8GrgERcIVHOnHLFgdU1Ecoxk15QKYb5F9ldPbAdMpEJEk/8JAaFlQ1TsMnmLnwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdozM6DT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdozM6DT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B63AC4CEF7;
	Wed, 11 Feb 2026 12:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770812001;
	bh=GsgSVk0yQMNeMELSV7tddgM3enuVuEwnc/fX1tIfwvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdozM6DT+k/vfrj2ztwdlVh1CgUSGOab02fg/h+z8MdK0SRt9gYJbNtJvars+qHlC
	 VTVQyd4v4w0ryL/5dAhelMIJwGeavyaCCQjWSj82bV8t2LCTzECkVMiJ1aYHyxCBH8
	 ZhAO+Rf3IyJWS2FqrXhyuwJLz1nb+epRjj5WNg8Gsgh6UYOUFQOSh6Zn7aMRz7mGcw
	 E2z1v206NmVXMZ+4HsNRE/qmG/1HEnYONBKiAKPqbffaRvco+o8z/tWWBZWZ2MNJrN
	 +t8fj32wTKlg2RTsahev9M/oa+KT4MLz+bpUzTNNMpekIKfOZ/yaALisoAD+9dtkht
	 gSkibNqBYWdtw==
Date: Wed, 11 Feb 2026 13:13:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 3/7] mount: add FSMOUNT_NAMESPACE
Message-ID: <20260211-eurem-rinnen-3569a208531b@brauner>
References: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
 <20260122-work-fsmount-namespace-v1-3-5ef0a886e646@kernel.org>
 <ad810bc9-5755-416b-a810-5c1019b85b76@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad810bc9-5755-416b-a810-5c1019b85b76@sirena.org.uk>

On Wed, Feb 11, 2026 at 11:47:39AM +0000, Mark Brown wrote:
> On Thu, Jan 22, 2026 at 11:48:48AM +0100, Christian Brauner wrote:
> > Add FSMOUNT_NAMESPACE flag to fsmount() that creates a new mount
> > namespace with the newly created filesystem attached to a copy of the
> > real rootfs. This returns a namespace file descriptor instead of an
> > O_PATH mount fd, similar to how OPEN_TREE_NAMESPACE works for open_tree().
> 
> I'm seeing a regression in the LTP fsmount02 test in yesterday's -next
> on arm64 which bisect to this patch, the test reports some unexpected
> successes with logs like this:

Thanks. This is postponed until next cycle.
