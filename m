Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280203;
	b=usG0hTCXbfNODMvhz/MRaCgHzb2FVajl5kar5dKdUvD8Ih9fZvXdVd1ZuR/EvdcbNPgh
	 PsvMKCHDbpS/S8el72izm7IHW6onQCA3ai+da36Taw1K8XfYdaffmbGUY22Mx1yns2Qxx
	 LltHnZsuBe9DKT/PCgCetse/wdHl0M+2zMedZVfwE8CbXkE6VYoIEMmicAdTK9x4qouHu
	 rAfgy7ZCjiGdo27fxDRnIBBOPaQARoJ0/U/jqKWX6bdftFLzEeeQmzVH1qH1iOWdDMiOH
	 M4ZA4xs30WU70WWA/z20E2rJuGyhzuYNqGh5P5cOQK1gnTkoQ2vy/0kgQzDVYGGZAXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280203;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=p+3Crhy2vTaTH2VP8Hqb2z/w7m3gLKgpAXgDIf/pTwE=;
	b=vDlr8nOUjWJLeqgoeIu3V/G3VgeDspZKyI/PkH95JmMSby2Nd4pBveZfGSvBIlB0T3LP
	 //n/XVFIGTT0jfIBdb2YZsxWDylx8ndxu1wpqVUovBBsYxfVrdjcwxy1GpOYLoGGqzEs1
	 Jz/+O8+QAyb8APB60nK7YYThgsOESWLBkr2wHYCaPqT7ZhiRCgEPaxwmhRmNEX5YyAF12
	 r2hMklZ9eZN5BYC6NHZiyJv1T/8x0DGm4khavJEMUHoeiWiY2Wc6RJV2IGdp/6CYGby5W
	 pTjlggt+gy0fc9QdVoUIT/oiRMknofSmIVCW/ku2I/UTn5kDGAczMMJdNNlcqbqfqNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MBinKNbI;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6D606A31A;
	Thu, 29 Oct 2026 13:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC6D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MBinKNbI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793280203; x=1824816203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9Cz3qGxvThs0rl/GR84Oy3PnSJHjpp3B9x+qw2O+AJs=;
  b=MBinKNbInWo1azOpxCckzEmKPOm1qJhWDP0SKyHrQktYkzYTDDOnvgy+
   Mp5XirOOcE0iqD0MI2yhoMUOt9eY0V9b1ASxPjrG72u76eaEpalhH7XUZ
   fusx/thYdJ/v6Zw/PS48jRttvL7mMk9e87pFXCCAwzaOoFDS0Ot2ZYgN4
   LSbbMDAK+X6K+v2OhSgj8owP7KMBB+WMl1tJX9rYqXaM/WkymuQqD4nPC
   0qDuChHGA4No3BYe9PhN5w3ih7l08YUWLE5zU6ikD2D0Oh+D2FUX98twb
   nej4RnUiyULLFN24BYdAV4lAeAjE7Xujxx+oqI3J+HFJSZ2kS02oA87fg
   g==;
X-CSE-ConnectionGUID: k6N2Pc+ZTumlYsJlEhrExQ==
X-CSE-MsgGUID: +avD9XYuQiuQ8otbTMop9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1905320"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1905320"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:23:22 -0700
X-CSE-ConnectionGUID: sK2vSRAjTAqdx5FXxpCvqg==
X-CSE-MsgGUID: o1lYrOQHRt+E7suodbHRNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5156292"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:23:14 -0700
Date: Thu, 29 Oct 2026 15:23:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-leds@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 07/10] drm/gem: Switch to __nonnull_args() macro
Message-ID: <auNIv830Zu_1zWE5@ashevche-desk.local>
References: <cover.1793027261.git.d@ilvokhin.com>
 <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>
 <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
 <CANiq72mMm75svCqevd8fHtVoczDpvpo4NwL0SC8=bWy030vQuQ@mail.gmail.com>
 <auNGJhSe3tVi7rDy@shell.ilvokhin.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auNGJhSe3tVi7rDy@shell.ilvokhin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 29, 2026 at 01:12:06PM +0000, Dmitry Ilvokhin wrote:
> On Thu, Oct 29, 2026 at 02:00:28PM +0100, Miguel Ojeda wrote:
> > On Thu, Oct 29, 2026 at 8:32 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > >
> > > Should gem.h now include <linux/compiler_attributes.h> ?
> > 
> > No, it should be included for you (unless you are doing something
> > custom with the compiler flags etc.).
> 
> Just to add a bit more colour to Miguel's reply.
> 
> I believe idea behind include/linux/compiler_attributes.h is to make
> attribute wrappers as simple and transparent to use as native compiler
> attributes. In particular, this means they should be available in every
> kernel compilation unit without any additional effort.
> 
> For this reason, all the nessesary plumbing is handled at the build
> machinery level (see scripts/Makefile.lib:171), where '-include'
> compiler flag is used to pull in include/linux/compiler_types.h, which
> in turn pulls include/linux/compiler_attributes.h.

Ah, TIL! Please, discard my comment then. Perhaps we need to clean up all
headers that pull compiler_types/compile_attributes directly (the same way
we do for kconfig.h).

-- 
With Best Regards,
Andy Shevchenko


