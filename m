Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263448;
	b=0jNCowiALmHgVQ+Q/GVmF/qD+rXoruJteOtSOmdXedUTODjF/uPckEpRV64TmvbdIjpO
	 ISqg8qCJoeosP1iwQf6tf1fV99WFo/F+pIuPuTemioECjwdQQmYcMjSwxTF0JfNMgjlUs
	 F4VrK8MGKP04SopLnIMbDjreOv8rCphIFwhR/KpkGRvueJrH8WnaJWdW061S6paw+qXkZ
	 ZZnP+3Dm7BecpQSZ4anYBoetaOuDVoZ2b6oUulUS8g6od8QdPd76Aj8xR0MNm300idvFx
	 XBfLCOEPOxTrbKJFusNLWLjM3uETKiwJ+vCMZ6LwKtIYqeLD1vWaI9WaaAU6VGaKYMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263448;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:Organization:References:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=YDl9p7g5quENVJzD97vvD5OqlYe1ysXU7bQyzl1X/uw=;
	b=T2+zme69izMTXh5CL2T6ypE79nfQRvC4yE+IBLx3Q6m/uh/ZXBySKYRYPKxovW/KF8zT
	 YxF7iWPi9l2ZTORGQynHVW3tYR3H3928+wGhBk1xAOwEkSR6d7wAuhR90zrncBzSF3h2o
	 B28wIob1zhxF1pLB2q/feihuaSEIqSZnWyyK8791JyMZlzBJtvlxWqIpeRJUnCzeyK3TE
	 hY/iIU3oW5ZcU8CXm/FecSUFm8V+n8DA/Xxr342dtWBH1hDKzF4Dj0rlYlDjJwd/Fs0MC
	 IWF4afsxp2gvW2J60xoH7o/41y/y4KmjeO7peEzL9ECPb9brobncIcwFfucoVCEKfvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kwj2yoBg;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9469606A31A;
	Thu, 29 Oct 2026 08:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9469606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kwj2yoBg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793263446; x=1824799446;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WP/QAZ7Uc8hCjUk9W10FsuMb7rLn58PCckd869LjBFA=;
  b=kwj2yoBgupyp5IAV0wK58klQS9NyrD3FpPZHuPNibHJZvXoMXe1ONcDQ
   lxjQi6P5W13Cw2q8CmZlim51OjyincDA/L1gVq57Mg1ct9HZHUfyuSdtu
   lNXLO4bvGoV0uwpCrCOkDMMzEqn5jV6tA5kdDBk3HeOtaHDw5qu3mJCfX
   paLbRGWPiT1NJhQBbd+vsl0SOVK+mM/iOZAA3CfsmvEAu3W4GdimuKXd6
   nS6rtFwsyWu6JL6EhDS4F3VSzASNv7B9YNyPmb9kEiV9O487BzX9A/eXa
   q4SobvY8hehlW5EC6+5SIcflMiOja0cC86OKyCf2M+Jf41jMEhHyIDGxs
   Q==;
X-CSE-ConnectionGUID: CqrrEIrhTsiTytS8gM2RUw==
X-CSE-MsgGUID: lZrwwhGjTaGVPSL0h2s3UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2011321"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2011321"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 01:44:06 -0700
X-CSE-ConnectionGUID: oDqzyd5cQ0OZV3ZmvaMS7A==
X-CSE-MsgGUID: gVbT5JW4Somf8pxelwKQ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5411378"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 01:43:59 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>, Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6n?=
 =?utf-8?Q?ig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel
 Machek <pavel@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy
 Tsai <billy_tsai@aspeedtech.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>, Andy
 Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@canonical.com>,
 Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 05/10] drm/i915: switch to __nonnull_args() macro
In-Reply-To: <auHf-pdvGkPibgTp@zenone.zhora.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1793027261.git.d@ilvokhin.com>
 <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
 <auHf-pdvGkPibgTp@zenone.zhora.eu>
Date: Thu, 29 Oct 2026 10:43:56 +0200
Message-ID: <b3045bc3ae77ef78a1f479448a5dc780d89bf38d@intel.com>
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

On Wed, 28 Oct 2026, Andi Shyti <andi.shyti@kernel.org> wrote:
> Hi Dmitry,
>
> On Wed, Oct 28, 2026 at 08:19:44AM +0000, Dmitry Ilvokhin wrote:
>> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
>> nonnull") added the macro __nonnull_args() to wrap raw compiler
>> attribute.
>> 
>> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
>> nonnull attribute usage across the tree and keep the attribute's quirks
>> in one place rather than open-coded at every call site.
>> 
>> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Pushed this patch to drm-intel-next, thanks for the patch and review.

BR,
Jani.


-- 
Jani Nikula, Intel
