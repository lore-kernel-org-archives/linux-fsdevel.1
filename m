Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63856363090
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950465; cv=pass; b=SyOup0s/PQLbvEWQ/yumMIoBMwnO+U3l61ZsxbJzC1LAnRkyYmoEfqEH4ynNrEDrhjlwshl0nd8Oujz8yAjN8Ceh3QYxP/yjpszrWNveF3cGE5BXkE7mi4qQAro2dBbp9d7Hn+i+AeKhw3XupLKcTTIEMMxQoLL2K16QgnhijLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950465; c=relaxed/simple;
	bh=f+1hgjoLe+9OAau5GDXmSyjb/F1lcu3rz3NObPtffwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPUIxs0ifErgOorFbPL6NJWwlqKvHG/5hTjVNLVl2XPtGs9tfKtoqJNUIr9/o/8vGkB0+BcNWKhvHaSExEExzwBbbYW1u/HoDI4DEGCCQjBwG9jN+DYLKm4W7vT3lsjcM1ZI2A3Gjht7UGoc8t7ekCSdNsuKAUcGDuZD3sdIPUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT1xHc2x; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT1xHc2x"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc8311c6ddso1672325ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2026 10:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785950460; cv=none;
        d=google.com; s=arc-20260327;
        b=hGv1aM925Z54dW1UEA0yu075xdZs0cKk1YzXoPRiRAh9EJNpicO90Qj4sXHorRX/TX
         nWtosiNv4RRnlNZkcOrartDjkpkIahuTKbxlmQlz/4fGVJqw5h2TchUOoA38myHjV2As
         xRaq1VdCgZrgB94U96va0/SZ432aDjfWWrT0cUZrvgsExk/kCZ8RpKEZm0W/qENLEXhu
         AKiO64j2VhtPgX2PKTuDyqj3x1D1azqexS2zgcvTmutBcvKuK1HzucaC9pnvJRX18yBg
         S3moXwuRvbE9LtwBpTmjLWHTl2PbKJqunIj2Qc+9P3L5Jqok565kqrxr2PvjiizGdWnz
         TLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        fh=YSAbLqK4KAvftcassmrj2C8RbQ43cwzcxJdXmBhS+Hk=;
        b=MDd8tPRZ0yKjSGwzoYVVrsJFcyrVYpa9s0nZfzad/Gu95FhV4JJdVGwAJbw5YdpqXr
         HSQfER3Aw1Uuxy/7PMlZ0Yz0zSEz7YT3+HCSCe9EWISylJpVvr6NVsQcnO3D0h3efURp
         mEvJmhXhxyPnomozspLXLgXxnLnJY4rupBlk0+2H7t8aTn95PjhhG326DNQiioZmOk2M
         rv+JzfpKAzaH+ezg0hlzbgKGnZwzX+R7DELnf8yO8Xl/eF72ByzPESS6EeXQhViKeMFI
         qzv2i1ZhVZeHUbTmj87EGK1F8ulXHWzUSkIXTX2zfv4ljCsWpAKK1Zj0UkHJ2NOD5d/n
         St5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785950460; x=1786555260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        b=ZT1xHc2xyP9XYk8PUPnDAntsicElF5elLjXJHYxK/dTIRxhOXP4BYmKyaAm7D4myJe
         FXySCyN7nRIDJjvQu9UXCW9eDvMXBTKWNXVzmoLwbtoeTkM+2avemvUwcCdFVmdxcM5y
         HMcojfHT74MtjHUYX3FGuPiSQu6CG9RcMZN10Jij5DCneHFtm2g+5oKnouFZiqpXEehp
         s6g/qW8DnpBdkqN4RMvOha0mJmzKRXFYxdpGFxxrgKrHq8SOqH3+XjNo42K8aYfHQQpY
         ieaRXp6TarxQO7iZdwat5LWdNaE6ED/8Ui2j8nc1nYOEyzIfdGs6la8xuL4tQi7opQXq
         gWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785950460; x=1786555260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        b=Huo/YIZHiH3GmfC9QxH+Q1FBVkat5WrRlBrzQoKBtTECp2k6aJimXL+tujMqeA1r7R
         lIDZUGT+NKBgNx94f0h5yIdhx3nUlElvDP8VCsyToIq440tQBBNOrAhE3aMphO78+41j
         vHGsYSbW1/oVGmx3w7teMCUgh+Q7jjSSwZ5j4nGr4ql3dUQoC76DuFZ2lhTYjIqsEkbE
         f2wjE+DDwfUr8ddsT2YMuAuyDat/SPF/PCloH21UkdJMA7/TE4e4F9wxsntq5b4x51pr
         ct1HYENOZd1XRv2RrSqWvHyqAfKcLJptZ/jWwVK0IrDnztD2gtX2/OuejSXqMH8u0Tl6
         BddQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDAls5tjFKl/MLc9zh3Gt7k9u1EgureoA8ly+KFAGuYRLhFh1WE2Gm36LfRGn+JmZWPRQQLqpdi42mdLXf@vger.kernel.org
X-Gm-Message-State: AOJu0YwXV0saeLq3VEBv7OZfXoVZCFVWdaUJh86YNzrCPjxqw3il4Flq
	nkM/QPUWSEddGYR03Kq+uouxRupNbJ1MhvINDqW8s4jl+GWbLwu9c/qsIVVOOd2NFjHPVjTiICX
	5H5BMDLjcZkJqlaXa7mIcxhlpCb81xu8=
X-Gm-Gg: AR+sD12whgZAJJeOpMR/JRwBFuzbuKf+j+NXxYjS/JUXLOaZquWInygFHTeCMEUn2Ca
	DscQK1+o02mukcAd+aE5z3zywvQZ+76d36mWFoUGE+2GWaTmTvvHxY5kCyLA78sHqBh3+ulK4RQ
	eQHm2yjb7NKZvXK7qcY13512TT/XmIopncfDD1b+EZP4VuRaBg956rZ0UdbccVeEBv9s/Tdn35O
	sbVDLg2WmunGyTVF2vSCAbyt1XyzL0/JauNX8ax0eiGMYBNJ5LiMRYZ9ZK7ai0uEdz2XGvrHW1z
	3zv6XatneQQ81bbSz6f0IKGtP+CG4/oYTMV4WrsqcmMxqUibh8SMbwix2y8+WqztgL21xQnmUQW
	XYfyxUn3VZ/irh/qFdcZFPyHsnVQ+Q9HQesRZl3HHU8jpjKyWF5ehvrElcyqG
X-Received: by 2002:a17:902:ec8a:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2d0ca1658f2mr73522915ad.0.1785950460122; Wed, 05 Aug 2026
 10:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0CoR7Z5B4-PH8GYYbWlZysVJpMnNLTFzTO0tBlOpJQNFiQ2CPrhdjyD4-4jQs4n0J_1QqovCd_EaYpclyigEKw==@protonmail.internalid>
 <20260628095132.47753-1-trev@trevrosa.dev> <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Aug 2026 19:20:45 +0200
X-Gm-Features: AUfX_mwN2wRwvmcNPuq0EpEyS5qgayFtXbsdflDPhbgmFxUJf-YMOIqJTLTJEvs
Message-ID: <CANiq72=wo4LOfa3hrJhTFr8UzkchW4QQtUespCTq7qRJvrr6CA@mail.gmail.com>
Subject: Re: [PATCH v6] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Trevor Chan <trev@trevrosa.dev>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	airlied@gmail.com, simona@ffwll.ch, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, igor.korotin@linux.dev, vireshk@kernel.org, nm@ti.com, 
	sboyd@kernel.org, m.wilczynski@samsung.com, boqun@kernel.org, 
	gary@garyguo.net, axboe@kernel.dk, daniel.almeida@collabora.com, 
	shankari.ak0208@gmail.com, lyude@redhat.com, j@jananu.net, lossin@kernel.org, 
	acourbot@nvidia.com, markus.probst@posteo.de, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, david.m.ertman@intel.com, iweiny@kernel.org, 
	leon@kernel.org, bjorn3_gh@protonmail.com, tmgross@umich.edu, 
	tamird@kernel.org, work@onurozkan.dev, sergeh@kernel.org, 
	matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, jack@suse.cz, 
	ljs@kernel.org, liam@infradead.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, ptikhomirov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:26=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

In case it helps, there was a v7 of this one:

  https://lore.kernel.org/rust-for-linux/20260628100731.64885-1-trev@trevro=
sa.dev/#r

Cheers,
Miguel
