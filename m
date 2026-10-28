Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187231;
	b=oAVaHhpkz521rXrJfaxf78QPj8wUNqAfmKWzMllgTMD1/Lb7spoU/hm1fm9XSkPMCp6Q
	 77TyiZwtrpaEUe1AxkdyX9hCRTPze5uG1RoWb2JSUYbOLbL8gN3URNoBXZWeB7UY4zQve
	 N+1p1ptdL4rP/SRbCixrY2TP9kwXjsSnQt2GGpLdB5H6m1R7tyNbCeZAGDU3TLgFRsSJq
	 05V39RRRZdF0dtRDmzMy2yyu+99a7KVTHZgC44xl1sFfp9uZxbJHCZE6Lq03fK+Od7zE+
	 6mZVdYAl8PPVvqZow1bt1/NBmy254KJsMOZdJY8h/PLUxFet1doyUwxtC+7hcu1Pw7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187231;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:Organization:References:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=jLuXcsrhYze/uot6RAritgtezmvs46B7suAi1iRl0v0=;
	b=A0pi3kk96ukyb/qHJUzwZRjFTNu75826ktHdX3PrbOF6bw84j9MlYmDdstg0vJsG6EZO
	 p0oUpJKDieRZe+xYEz4BU7Z9ZJ4jgaE/6rW8f6+ryPvUNGC/hugKAggOQ2aRAc+++Gyd6
	 Q9GMfKTWlqz5+sbkij3d5t9oSpjz9R6zt4Jb86qBnAZPy2HSaBix1x2jVrZrSvsuOHbpZ
	 e6Bvt+YSnE7AIzAzi5ASm4MdWjZcCIspyFPc0by1kzEb6yaMfdum9dq4eifh7KlNxWwF+
	 5PSOeRRlawU1DvmIwreJn6lBppVZ6UTfhu5uLjX9MN2Ki/NKzMgm5SZP3s8UiiJgtwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JGKF85hm;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE1606A31F;
	Wed, 28 Oct 2026 11:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43CE1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JGKF85hm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793187229; x=1824723229;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=z8y8XV24bROqh0zonAMNAjIZyMJbY12xpb+/fK8m0AI=;
  b=JGKF85hmCVQ9pf9eXbOsC8wgPHWDavTdyCGWPRpxPC23gPTB9HurHR1u
   WQIzCd0zwuTx3xDYu7R6x7Tug0u3cG2len/6bLyuT1Ba9nt2Ksz9lFv16
   uWsDoRlbFOlyD/wV5bIxwsw3kIwHlbx+7870/Q08076xKsblgMcUIm7Xw
   nkUIXIu5vX0mQFDdirfJv+J+GkeTU7aMk2olzE59xTR4u4jE9NpgRt9lo
   j3gf2C66LaqLw0qU6mJ+rQfIH8X+Zwj6uep7ZyHB2nWJbxPDyFDqeTPXW
   uH7NK1RnZY34FW9rSVNOCVg9/KCrbR1XNYeByeZKByf52EvDlzja4Tmz3
   g==;
X-CSE-ConnectionGUID: LjtfTqsfR6q7+D7U9Clktg==
X-CSE-MsgGUID: ULH4gWuCRSGUwGXlKvyOzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1813628"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1813628"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 04:33:48 -0700
X-CSE-ConnectionGUID: F9mrBK1+QXS8jOjCv8P8bQ==
X-CSE-MsgGUID: KJ1QgI6jS6ey2L/RLS17LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="6633584"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 04:33:40 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Dmitry Ilvokhin <d@ilvokhin.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones
 <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook
 <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Andy
 Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy
 Dunlap <rdunlap@infradead.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Dmitry Ilvokhin <d@ilvokhin.com>
Subject: Re: [PATCH 05/10] drm/i915: switch to __nonnull_args() macro
In-Reply-To: <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1793027261.git.d@ilvokhin.com>
 <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
Date: Wed, 28 Oct 2026 13:33:37 +0200
Message-ID: <3b839373c03f6b8aeafa8e4801a486ece68b0815@intel.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 28 Oct 2026, Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
>
> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
> nonnull attribute usage across the tree and keep the attribute's quirks
> in one place rather than open-coded at every call site.
>
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>

Acked-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/gem/i915_gem_object.h | 4 ++--
>  drivers/gpu/drm/i915/i915_request.h        | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> index a2f4b6758a65..648d0b4139cf 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> @@ -127,7 +127,7 @@ __deprecated
>  struct drm_gem_object *
>  drm_gem_object_lookup(struct drm_file *file, u32 handle);
>  
> -__attribute__((nonnull))
> +__nonnull_args()
>  static inline struct drm_i915_gem_object *
>  i915_gem_object_get(struct drm_i915_gem_object *obj)
>  {
> @@ -135,7 +135,7 @@ i915_gem_object_get(struct drm_i915_gem_object *obj)
>  	return obj;
>  }
>  
> -__attribute__((nonnull))
> +__nonnull_args()
>  static inline void
>  i915_gem_object_put(struct drm_i915_gem_object *obj)
>  {
> diff --git a/drivers/gpu/drm/i915/i915_request.h b/drivers/gpu/drm/i915/i915_request.h
> index b09135301f39..f559203c332d 100644
> --- a/drivers/gpu/drm/i915/i915_request.h
> +++ b/drivers/gpu/drm/i915/i915_request.h
> @@ -437,12 +437,12 @@ void i915_request_cancel(struct i915_request *rq, int error);
>  long i915_request_wait_timeout(struct i915_request *rq,
>  			       unsigned int flags,
>  			       long timeout)
> -	__attribute__((nonnull(1)));
> +	__nonnull_args(1);
>  
>  long i915_request_wait(struct i915_request *rq,
>  		       unsigned int flags,
>  		       long timeout)
> -	__attribute__((nonnull(1)));
> +	__nonnull_args(1);
>  #define I915_WAIT_INTERRUPTIBLE	BIT(0)
>  #define I915_WAIT_PRIORITY	BIT(1) /* small priority bump for the request */
>  #define I915_WAIT_ALL		BIT(2) /* used by i915_gem_object_wait() */

-- 
Jani Nikula, Intel
