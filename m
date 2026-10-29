Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280089;
	b=oUQyaRPAlZx18YeGJndgIoJ+RGB2KEKcBjGMQkNIb4KL/KXL5mlJEmKXp3dFGnlNC7P0
	 HVj/9WMei0LhCu6THEuvucSuC8zzIEAPa+oUhRErWYJ2b+SwUzLm1WFR1bVAT8yQJA9vC
	 aOtJCrgF6IxCFFXECLL4PFOQecw9Hx4VrEY5+WVkWxUliUVaaZIlBa2MsgOYBlyLwWuhx
	 K4cR2sbeXPVMBLXK2vY3jmHCPpER3OI4NbYzYliaV3ODPrUPigEz0Q97qAiAioPTfA7ZD
	 DEbAojNSkWpxWiQpGcNhQzdn9XGxFeTTKWIc12ms276ALabUBoNUpMU6RvSyJNQSSOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280089;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=SdAws15E4boPyFwiZCIHuT2z7R3eozeBP3yjVNgMrMs=;
	b=2uqIEnixVzr02J+Pxg5r4R0Sb4AomQzRSZnDHeW0rd8Hsf1KqYNy+UU+xpBIQ71FCAQM
	 R5XNzByxFZU7x+ar9TvmLof3PzI8A4aLY4pon8FhHMzt7f3QS7HFnu2En6VWHpmDnDG90
	 NKVQAboNzT9z9f6590h6twievrJy+fea5OjGPuDvn6A7nW5h5i3uZWHqZrtSrYDAxosD3
	 BYt+HQVRTeak+z42kOu3YcJtyOjvRy+gX/dkh3LNz2Tjz3vJ/e3GeN3aMOnHcVS7Bl+RL
	 jbYNGh+kwE6i10zY5gFqmEAbDIwOugtP+I2pmtWvSGbAGbk+f1nAG9O6t5ulSJFrcYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ByWpXUDN;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADBE606A31C;
	Thu, 29 Oct 2026 13:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ADBE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ByWpXUDN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793280087; x=1824816087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tkpV40hGhO5XeSgRXjpBId5i/GBz5co0mYtfaR2uPHc=;
  b=ByWpXUDNtE041PcxpjxWOiUscgxyB6wd6HHSHpTkfdqKrHt0nNRiVlNi
   iGklM75b35IAYUuhXooKHYUmke4On3DONklwepMYt50Djjh06D7hR/Rex
   esUsgPmXo0WZuKINjKwAM6b4UUGSGG7PK3uLp0KOwXMJ9Ve95Rq71K6ok
   ZTbVwrJtQ3UAP5w6ouWkzPjbCO2HwwJ57OkdBxrphXE17pJpMMiUe3njz
   NUk5U7n9eOiQY0ZCuPOO+1cX7gC1QAHtyYunBwh7eVVMghapDtlxlu7Qu
   NlkGAblFP0nufHK66JBOIdzsfzqWVolsTSSd96UzdOwOj2C2cf5pu4X9r
   g==;
X-CSE-ConnectionGUID: +k1Ihz39R3K8ZALfvQQJQQ==
X-CSE-MsgGUID: uu/Y6S3UTQGW7Z75TckLBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1899923"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1899923"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:21:26 -0700
X-CSE-ConnectionGUID: lcHCQ8oTT4+RWbV1aJm5jw==
X-CSE-MsgGUID: gd6Ro2tCRA6pOUXdfheN3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5690610"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:21:17 -0700
Date: Thu, 29 Oct 2026 15:21:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Dmitry Ilvokhin <d@ilvokhin.com>,
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
Message-ID: <auNIS5n2aUD9t7yB@ashevche-desk.local>
References: <cover.1793027261.git.d@ilvokhin.com>
 <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>
 <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
 <CANiq72mMm75svCqevd8fHtVoczDpvpo4NwL0SC8=bWy030vQuQ@mail.gmail.com>
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
In-Reply-To: <CANiq72mMm75svCqevd8fHtVoczDpvpo4NwL0SC8=bWy030vQuQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 29, 2026 at 02:00:28PM +0100, Miguel Ojeda wrote:
> On Thu, Oct 29, 2026 at 8:32 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > Should gem.h now include <linux/compiler_attributes.h> ?
> 
> No, it should be included for you (unless you are doing something
> custom with the compiler flags etc.).

Usually it comes to the mere drivers via types.h, in rare cases (usually some
more generic library headers, we do better granularity as it affects the almost
entire kernel. Just double check that types.h is explicitly included.

-- 
With Best Regards,
Andy Shevchenko


