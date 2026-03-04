Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8836604C;
	Wed,  4 Mar 2026 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655774; cv=none; b=osvNV2KvEiJOdBXwa8YyhvQcw/uznu6pAVsWMpBf+KKuegxrqUwiDYT1aRplSsRPhFINRGWPVkHWDqHeBSLRIeKPdm1pplpsxxOTIqiqUh3nAr3vNCkd65fYV39OtNRqbECl3SWLRfbZPikh2duPYlIsLEEYG3rJINUCkGostpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655774; c=relaxed/simple;
	bh=jfZm5vSB1vPzvk7DU/3ZCqj4liPErRh64IDVyat3SkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBI6bXmI8a+dlhi52fdXKczDAyK6/HMJylWak6SYl5B8vP0jXevkqAXKcj4Cs8S+0WaQW7yn9XxIhXz5O/FW7drHR4AONpYM3zsMVE3sUMS/UHZCD8EwXgrs4M4MTQaUQ31FavcLk3Kkdv0LEdNRUVYi+7iCh+pl1t6YmuAMuOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTMkYtJ3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTMkYtJ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772655774; x=1804191774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jfZm5vSB1vPzvk7DU/3ZCqj4liPErRh64IDVyat3SkU=;
  b=FTMkYtJ3iz4jOdpBgc+RwyllSaBWMV9NBEue2mouBs3zzTmC3YUFHVlz
   M5HDlhoGVNgeoZmkb4yMU4MOM3YkkqW85f1V8bIdzGAT6qcKVIJ8a3/H4
   37r0bS3QKxYAE1F9B05FDch7jnvydLE0nqjQBB6bWIqE3C+DzOLppZxVf
   +iV5aUD4PKH78aqPOEj1fMPFdgIOeEqI9HLfSGgxitZNlFuha6IIYUQiF
   rz9F9/7VNLgqe0Dkt+VXuGagqxIdmzFZfWL/1HAnHmCJtqa/T7H+47RhL
   LO1WwogecVoDKeMPEwUol0xs0zn6EhYeJp8Q2tPdc9rTem3fxAoSujvsO
   w==;
X-CSE-ConnectionGUID: 9N/XvTA0SFGTPxGHJ4gk0A==
X-CSE-MsgGUID: tTMT/AKQRcWbgS9kdExt/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="85077241"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="85077241"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 12:22:52 -0800
X-CSE-ConnectionGUID: OzPxF9lORb+fO3kerP7c3w==
X-CSE-MsgGUID: BRuPXwfQRGms1xwwyAoOWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="217688413"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 12:22:52 -0800
Date: Wed, 4 Mar 2026 12:22:51 -0800
From: Andi Kleen <ak@linux.intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Subject: Re: [PATCH v1] docs: filesystems: clarify KernelPageSize vs.
 MMUPageSize in smaps
Message-ID: <aaiUmx8yRsn2LBMW@tassilo>
References: <20260304155636.77433-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304155636.77433-1-david@kernel.org>

On Wed, Mar 04, 2026 at 04:56:36PM +0100, David Hildenbrand (Arm) wrote:
> There was recently some confusion around THPs and the interaction with
> KernelPageSize / MMUPageSize. Historically, these entries always
> correspond to the smallest size we could encounter, not any current
> usage of transparent huge pages or larger sizes used by the MMU.

It still seems like a bug to me, only documented now, but seems
I'm in the minority on that.

But anyways if you change this file you should probably remove
the duplicated KernelPageSize/MMUPageSize entries in the example
too. That triped me up the last time.

-Andi
