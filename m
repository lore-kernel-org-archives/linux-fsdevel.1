Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86CF4B04BE;
	Mon, 17 Aug 2026 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951838; cv=none; b=isEHCHsl/piDWoLPB51KnuP+JcvlqgruS/5RgPNq4En9joNm6Pum911TAqD4LBED44QN0Rh91ZJFCPe6mfYAhKGeXc9+hXmWCVJ/pu6p35J7KOUTccUeDJvk2GpCBs3hENv1nD3CEQn8+MZQEwvuHKxDDbvTaasZVVA/8Z6GITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951838; c=relaxed/simple;
	bh=ozRkm7OuvnWhE8mHZWBVul5Mag4lw9ZVQvYss0rg8bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pllRRgr16Phi/l67TFDmWW4g6SAonVRXj7ZWmpnEfR66t8gpvMpCmmfP+11lDpoZ0dDcl2hdlVFZmtGmQ0zEiTMfgB/BCaED8DY7OpwtTmThFEaFiKcQqacphfqsMCOCs2prcCtuvcnV2ajqYNRgCaFBAb3WpLrephJgToY/yO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNufkww/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNufkww/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8531F000E9;
	Mon, 17 Aug 2026 07:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786951837;
	bh=FLoNOQ6/Hq/AXmKBdnnLKtv+2DPtZnxXSvIQmpdRcRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fNufkww/0DSwWGZMIqEEkYGZHZQXz+cM7t9a3k3OaORPIy52M8+jlPXY3ukszEhNI
	 irLeRgvFeR3Nrk0uMyL+vsGQo4/pVt3Sth+IxN+5OaHr/xOSo4SdmiC8ftkZY0fMN+
	 7HQonhuqPg1lyoDlJ+I4wCGk9m2T+6Vzi4GEf2cZk4ZryZtg6rOqKh4ZHaxfWNXK3B
	 DYilYJZwOClB/1JZ4f/V+Y0MTkBnUjDddkl8u31aJqUGbf267+zsgJbqhl0/h/KxZ8
	 FBYb/CFFXvCaMWUFfiQozOhuc5al8hOpnwMninN++2fKc194pKUgjnAO0ywiY0rrB7
	 jpVU/43E5exLw==
Date: Mon, 17 Aug 2026 09:30:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 15/18 for v7.3] vfs nilfs2
Message-ID: <20260817-notleidend-invasion-befohlen-d2a6a960ced8@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
 <20260814-vfs-7.3-rc1.nilfs2-f036b3577823@brauner>
 <b19a7fe07b79f6b47b58968a601e5ceb0fe9c2a3.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b19a7fe07b79f6b47b58968a601e5ceb0fe9c2a3.camel@dubeyko.com>

On Fri, Aug 14, 2026 at 10:26:56AM -0700, Viacheslav Dubeyko wrote:
> Hi Christian,
> 
> Unfortunately, we've found some issues in the initial patchset. And v3
> [1] is what we would like to send finally upstream.

Ok, no problem. @Linus please discard this pull request.
I'll get an updated variant out in the second week of the merge window.
