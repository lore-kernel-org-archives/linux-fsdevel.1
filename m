Received: from mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329A470453
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149540; cv=none; b=Y2BnPIhvoDPAHCdyOVwQ5AheXbYLTa++EKS3cYJ+3Y2ryv4fv2KlSbsb49N5xpVrYFZ3gjYe5DTvzC0ZKK6ShRUi1Apfmz1U0zaGlYcEQCsFLtr9pcx0yYNW0xIkriAwZ0m81hlYBnHaD3ey7GK/QBlbjUbFHrNvmPn2adFJlsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149540; c=relaxed/simple;
	bh=F7D5qGu4uRjwBMGSsIQKsV3/Fj/BGmgAwS7lQWwFDt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmc/2smY758Law58IyQUALfcRRUTn5nzJyLMPT4d3OuTT7+SS/mbjd40E8RR2zFRsx824igdZudoz5ueF70+xvmd9G7eHPqLUgzTJT0p5N6dMyOZignxvtm11LescJYF/o0+ttgqCdMhrK7pulAt/LpqfJHUYAJ2PvmN22M+I9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gMio4lEP; arc=none smtp.client-ip=91.218.175.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gMio4lEP"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=F7D5qGu4uRjwBMGSsIQKsV3/Fj/BGmgAwS7lQWwFDt0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789149534; v=1; x=1789754334;
 b=gMio4lEP+dJbatq4qfsoBGlNz1l9WGn3FgC0HHiVOUfEzuUiJCJncF/2DleylZjMcpTj9wyv
 SXAMuurueMRxmkjrUlzTHdaUysJHxfUq/wtargbK3vfwabEcgPWHR7J7Rzoi09BIPuqD4Y2DB1v
 st3RM92YkZWw46R7UplLp3nU=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 74a5b868e6abd71d;
	Fri, 11 Sep 2026 17:58:54 +0000
X-Mizu-Trace-ID: 74a5b868e6abd71d
X-Migadu-Flow: FLOW_OUT
Date: Fri, 11 Sep 2026 10:58:53 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Christian Brauner <christian@brauner.io>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kernfs: don't hold kernfs_rwsem across dir_emit()
Message-ID: <aqRBPn7dzTMSNpcp@linux.dev>
References: <20260910003650.1680854-1-shakeel.butt@linux.dev>
 <20260910003650.1680854-3-shakeel.butt@linux.dev>
 <10a6491d3de9cd67dbeccda8bee4ae7c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10a6491d3de9cd67dbeccda8bee4ae7c@kernel.org>

On Thu, Sep 10, 2026 at 10:24:18AM -1000, Tejun Heo wrote:
> Hello, Shakeel.
> 
> On Wed, Sep 09, 2026 at 05:36:49PM -0700, Shakeel Butt wrote:
> > under the lock and emit the copy, and pass it to the resume so that a
> > resume within one call keys on (hash, ns_id, name) and not on the hash
> > alone.
> 
> Please split this into a preparation patch for full-key resumption,
> including the name copy, and a separate patch dropping kernfs_rwsem around
> dir_emit(). Keep the existing locking in the preparation patch.
> 
> > +	pos = kernfs_dir_pos(ns, parent, hash, pos, name, &resumed);
> 
> The fast path in kernfs_dir_pos() still accepts the pinned node based on
> active state, parent and hash alone. Please compare the saved name too
> before setting resumed.
> 
> For example, akl, ala and baa have the same kernfs hash. If readdir emits
> akl and it is renamed to baa while unlocked, the fast path accepts the
> renamed node and rb_next() skips the unchanged ala. Falling back to the
> saved key would preserve ala.
> 

Sounds good, will make these changes in v2. Thanks for taking a look.
