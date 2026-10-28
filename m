Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203902;
	b=0VTDwaKNk3/tQqr+XM0OiHnh9yURGiFVWrKaflhT5Ht86RMtnWM9UGrxkVQAsiqqshm/
	 5DibpZIQeVuNw4GMMgRcqGsOvq1JFNjwtL4WnmMPMnXhjsIt1h+ooSIZxJWZ0rTYycaMW
	 TW+RLteMeQCrq1oCXNPWs3cnZaDqzecVVCzSvePwHNxKpu/6lAHmdaLs+bRSnZc+wyOR/
	 LYHeK/hvmx7IIQHHUD27GjIJeFuIDiavsrrU0EWaHkqmafS47Pt87jJV+lpavPQeHHKl1
	 9rCRZhS0XeRzPRrsj/m5HDd2FWOf4tc8qzYepfyt4AggZ8h6a7OGYg230+j4f3omVQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203902;
	h=DMARC-Filter:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:X-HE-Tag:
	 X-HE-Meta;
	bh=uxSAUdDO3MwPK+26JuHSTsq458DkeZfKh4h7kUJVnPI=;
	b=rAmZPaehgngr5+/oU5c+kMbrkBHEGMs5+nwHwYsimvpEGZuCwuftXm37rNyQLK3cPEfq
	 goLu3GrOrOVP+JNxeS8tDyGjOAOl9pYVswmFmuW6sZDY9iiT5nwG1fCoyR6+TV5bA6iGx
	 fqpAOK3kvq3HxM7ns0E/Yg/4U4Gh2tPNbA7n59t5Z0jny29eFVOHMhZrLtZxzMp+cjekS
	 VtJF/je00S2Rwfi1lnYsASkIm6hdaBPrXHejM4EbKdV2qINTxDpf6wgLu8PV8WrAL97CR
	 29u624HTSBJ1YUKRU/Dkt1cwdG/NPoK8phjsw0VMlGhoxUhue1+a67TuSf3QlGXzB0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=perches.com;
	spf=pass smtp.mailfrom=perches.com;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA9606A31A;
	Wed, 28 Oct 2026 16:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCDA9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D9BA980162;
	Wed, 28 Oct 2026 16:11:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id A762B20029;
	Wed, 28 Oct 2026 16:11:26 +0000 (UTC)
Message-ID: <aacb76ee8a23f956eb2e778da7b125d86d164b25.camel@perches.com>
Subject: Re: [PATCH 10/10] checkpatch: suggest nonnull attribute conversion
From: Joe Perches <joe@perches.com>
To: Dmitry Ilvokhin <d@ilvokhin.com>, Alex Deucher
 <alexander.deucher@amd.com>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
	 <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas
 Lahtinen	 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>,  Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones
 <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Joel Stanley	
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen	
 <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, Kees Cook
 <kees@kernel.org>, Andy Shevchenko	 <andy@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Andrew Morton	 <akpm@linux-foundation.org>, Andy
 Whitcroft <apw@canonical.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap	 <rdunlap@infradead.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org,  Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 28 Oct 2026 09:11:25 -0700
In-Reply-To: <bc2cd702455e58feb777cdb230e3ba4f7e1db60f.1793027261.git.d@ilvokhin.com>
References: <cover.1793027261.git.d@ilvokhin.com>
	 <bc2cd702455e58feb777cdb230e3ba4f7e1db60f.1793027261.git.d@ilvokhin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: A762B20029
X-Stat-Signature: 5m56y4bjcqjn15doddn3439d63u3xrtz
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18kHAE4RjXJ/BeJ9lSamcdiJOrG4xRY5jU=
X-HE-Tag: 1793203886-334294
X-HE-Meta: U2FsdGVkX1+vO3ZouaggYmakzKiEViVwEjIkayqsOUxRh4Y+D03W9OsYvhntgdSUdjdTBgNAGM07O+W/OBkN7qiawu9kPLoFiAUred/Z/Bvw2Ynv8IG7qnAPxQ8uaps63yUCxrPyn7HCEVo07x5i6NYNvKDhGCJh54qqNDafUAiSXShW2FGTVwwUUFc93x1OQO9f/LKoTfr2/KbcvJm3wJYFIWxls5MSV6vUbxfQ1CWIN5fZL2IoMApFvaTjDQjqQiBboJBwZoq4pSCGSqpTDJvfdjT4vabv8HAYbaFYZefsnth8dvgSgzQtAJujUJ5T/R386onDul4BmhyfIQ2SbKwU1ePW8+59QlMTPdteTFyX32nsSOnI504//g+rZB3j

On Wed, 2026-10-28 at 08:19 +0000, Dmitry Ilvokhin wrote:
> The kernel provides the __nonnull_args() macro as the preferred form for
> marking pointer arguments as non-NULL. Add a check suggesting the macro
> over the raw __attribute__((nonnull)) spelling, consistent with the
> existing attribute conversion suggestions.
>=20
> Examples:
>=20
>   WARNING: Prefer __nonnull_args(1, 2) over __attribute__((nonnull(1, 2))=
)
>   #11: FILE: drivers/soc/aspeed/aspeed-lpc-snoop.c:230:
>   +__attribute__((nonnull(1, 2)))
>=20
>   WARNING: Prefer __nonnull_args() over __attribute__((nonnull))
>   #11: FILE: drivers/soc/aspeed/aspeed-lpc-snoop.c:283:
>   +__attribute__((nonnull))
>=20
> Signed-off-by: Dmitry Ilvokhin <[d@ilvokhin.com](mailto:d@ilvokhin.com)>

Seems sensible, thanks.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6856,6 +6856,7 @@ sub process {
>  				"no_caller_saved_registers"	=3D> "__no_caller_saved_registers",
>  				"noclone"			=3D> "__noclone",
>  				"noinline"			=3D> "noinline",
> +				"nonnull"			=3D> "__nonnull_args",
>  				"nonstring"			=3D> "__nonstring",
>  				"noreturn"			=3D> "__noreturn",
>  				"packed"			=3D> "__packed",
> @@ -6876,6 +6877,8 @@ sub process {
>  					if ($curr_attr eq "format" && $params) {
>  						$params =3D~ /^\s*\(\s*(\w+)\s*,\s*(.*)/;
>  						$new =3D "__$1\($2";
> +					} elsif ($curr_attr eq "nonnull" && $params eq "") {
> +						$new =3D "$new()";
>  					} else {
>  						$new =3D "$new$params";
>  					}
>=20
