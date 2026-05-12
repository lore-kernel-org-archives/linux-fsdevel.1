Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2D1448D5
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592388; cv=none; b=hAjkYecV7JD/GhgXzGten5fnBAots6GbzV9Jc2+EtHoJEWeraAg17de4LGvqi9SL1ZirOsO/wxHaeJhBS11BwNf9x1JSOtgqbtngXO8QA7ke+3US6MDKGnCdLxzR0a8uvJpRB9CMIXI/iTqE1Rpret6YTI94ZQ0huxtBEAtHnhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592388; c=relaxed/simple;
	bh=UrCVAaEomD1JBqShtBiRFlzxvPFrunwUPUxg9hoXK3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnSgt9oyGNsF7PvZSFJlCZbTya4YnWtgiqgO5xmeek/CCmF/4EKlBnoz9eZFu/S90+OVLzCsVUCM60kbNDk5hwSikGh6TIy8nwD0PThboOIQpbuXa4VuBA53Qp74dFqSXrnOWtFyuwXzEuREKsbuhkfhdTmdKizo1d/hsc44d0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9BmeYaN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9BmeYaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863F1C2BCB0;
	Tue, 12 May 2026 13:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778592388;
	bh=UrCVAaEomD1JBqShtBiRFlzxvPFrunwUPUxg9hoXK3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9BmeYaNDqcTlhY2/rQC1gyG+Uu5AZcd4Qd53oAz8VjtEh5GC21oLNG/qbMINqxyQ
	 y5qqCc0OXtPL4mGuq2LMpdWTHnq4+viX4aqX4WcmybaBD17sHXLAjH4xe6Lb7yUQ7P
	 a0Q10NDWVLa9ZFAC4F64jbQVlIb+RVkzM24CgRqqc7gGq4OXeQnovMftj6mbFtLKk1
	 jl8MRmz0hf1bTnZvPVIS2zG05DO6Ipb++lHt33PWoyxAXWxslK72LrUlGwYoqL+zPF
	 HbMPlY04XlAMdA4rLwvZY7dYYAdWHtWtNeYpRNchL7RqzEP0usDohFLKCMNGGVSxmF
	 bY33uGfePIyvw==
Date: Tue, 12 May 2026 15:26:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gabriel Sakash <gabrielsakash@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Faulty interaction between open_tree_clone and
 OPEN_TREE_NAMESPACE?
Message-ID: <20260512-albern-reitschule-18489fc9c55d@brauner>
References: <CA+PzELx7nhdo9XAJ7v3mb3hzK2LLTv6OOCHNdfnKJojX1ijoaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+PzELx7nhdo9XAJ7v3mb3hzK2LLTv6OOCHNdfnKJojX1ijoaQ@mail.gmail.com>

On Thu, Apr 30, 2026 at 12:33:47AM -0400, Gabriel Sakash wrote:
> Hello.
> 
> Christian Brauner, I have CC'd you since you're the author of
> https://lore.kernel.org/all/20251229-work-empty-namespace-v1-0-
> bfb24c7b061f@kernel.org/.
> 
> Due to Arch Linux updating the kernel to 7.0.2 today, I have been able to test
> the new OPEN_TREE_NAMESPACE open_tree flag on my main workstation.
> However, I have found that it and open_tree_attr do not work together.
> 
> At the end is the C program I used to test the following.
> I expect that the output is something like:
> TARGET SOURCE                    FSTYPE OPTIONS PROPAGATION
> /               /dev/nvme0n1p2[/@] btrfs         <options> private
> But I get:
> open_tree_attr /: Operation not permitted
> 
> Using "plain" open_tree works as expected. I have narrowed down 3 issues:
> 
> 1:
> fs/namespace.c:5196 => wants_mount_setattr(...) to check if the attribute
> changes are sound.
> fs/namespace.c:5101 => may_mount() to check if the permission are met
> 
> may_mount is:
> return ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN);
> 
> Because this is from open_tree_attr, the process has not entered the new mount
> namespace yet. This will check if the process has CAP_SYS_ADMIN in the init
> user namespace, which it won't.
> 
> 2:
> fs/namespace.c:5198 => do_mount_setattr(&file->f_path, ...)
> fs/namespace.c:5198 => path_mounted(path)
> 
> This attempts to make the mount attribute changes on the path of the namespace
> "file", and not to the (root) mount in the new mount namespace. It will fail on
> path_mounted because the namespace "file" won't be the root of the NS FS.
> 
> 3:
> fs/namespace.c:4952 => !anon_ns_root(mnt) && !check_mnt(mnt)
> 
> This checks if the mount is anonymous (it won't be), and if not,that
> it's in the same
> mount namespace as the process (also false).
> It appears that the current mount attribute calls aren't set up to handle
> mount namespaces different from that of the current process.
> 
> This issue is still prevalent when running a VM with a kernel built off of
> Linus's master branch. Apologies if this is already known about.
> 
> Thank you for your time and good day.

Thank you for this bug report. It has all the details we need. This is a
missing feature for open_tree_attr() for sure and should have been
merged alongside the original implementation. Thanks for pointing that
out. I'll send a fix for this.
