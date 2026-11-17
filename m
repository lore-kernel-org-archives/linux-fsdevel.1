Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925015;
	b=V8fSna3KsjawZf7LiFVbjFajKXZT9M7ur36BrrtGrH68j/trr8+0NcA5+XCUykN2ZElx
	 STCIRCKiZ/sYhK3bZ7JrU5EXSklJhW5WX2LBsqqLdkQL+Q2NbUe6IMewDwWF0e5oy/hJj
	 H+Lr7XFJTJSzYEI9sIvlkUomz6/+sP/jTNGbIWSzB1OlSlLQpDoVixDNd9XPBxjdX8kKK
	 qqoLHRmSgyLGTuqKFrEoLXsBltpr8v0xHO8nHHCtXjU1uOdK4czuGCURmkpUNkCu7ck/d
	 FA5v8h5JhOhn4orS2U8IdKf4AtdYYKNu2fjvaKlQwmjFrXMMhexbcAJv3AXMi2bN71g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=2h1C9uj5tkQ3mEiIvTmSMJ954wLDCZQUMgzTaXjTZV8=;
	b=5LaCsDYn/mQYrJCSxsJOuAajBiO3A7RvPR97FspO+dbMq8deLrlpoHhwNHNPn1kHOs9f
	 gWTo4PSbhHAjk0Yt6sG2PPX3IVLFYMUhZvVLLWXL/bBnHHQScX7fhBYveOoNy1C2XheWn
	 E8gW5HpJFUcOEB/Z6AyE+hQADkF/jbFNgLw+9BfYxo1PvnFl3ygfaeNYJ182iJ8D6kF1j
	 Psu31faat00ExH0tLgEhcrwdWdXyJpM52SINFWYqlLaX7SoxJhIlDUyR73di9bV6A+/j5
	 9QMF7+WYBUmDfSS55tp/RoQcarR6887tyxdJcSD+iSglichFuGozGIp7TgAGNyw3dtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n2tGsW40;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F1606A8A8
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 14:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D2F1606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n2tGsW40
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49953abe51fso30232855e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 06:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794925014; x=1795529814; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2h1C9uj5tkQ3mEiIvTmSMJ954wLDCZQUMgzTaXjTZV8=;
        b=n2tGsW40NbEk5VZiWp6AE3NfHFtiBWa9FaDOLprd6PlkqVKHirPu6IOQsnC9euLMCz
         OdlnymHlKSg0jyaHkfhjRH6yLI1TDvkSFUL88fYP4zmU0h9sR987iDFCf41mQeWcH2Th
         mU7fTlEbLN4BALGxKDkmuEoR5UmOErhmhovs8nExws7GOCnWA7fY7spOySUyjFcBsBmp
         vTgUKdXyYKT0qNHGq7flMwxMRrC71fRecIMjRreqcBuMQGXLUjuyihIul95Cxrs905SI
         Mj9vzoSJSBZxauFx2NmGXymPAOXSgv/hKdOzPEq6zjTBiCZxbvczUtTqcITwfaBFu1Ju
         SayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925014; x=1795529814;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2h1C9uj5tkQ3mEiIvTmSMJ954wLDCZQUMgzTaXjTZV8=;
        b=CXJhnMVkDwvLxpGjmIC2j0efyaNlWcXOccSMREP3MXH4Fk4P1xoqv3GDDYvxOSReYb
         f1SrfwgTS7fVk4oZUgiXK4ayi8JMagQtEytCy+E/jmksYZV3M6j4goh38p0CwWx64sZH
         QZ3nA/AxFyyQpnayESqs2dwzyjw1lmx/7C05yXVbalTIImNFyABbODqqykoqOzR/LOI+
         abLa4VEX2k+ZcsqFbRT1z3iimP8jxoslAyX8rh+LHPoeXeKMFGGM5JPs4q85m9mNs25D
         N8xnCs9DNURx1yYEkpU/WOW32/tf6JfgB95fMdAUcd93kuf3jzXh21heo82dDAHLkmTO
         2iYQ==
X-Forwarded-Encrypted: i=1; AL+hErFBRaHGDqlkgp+hUbxr1BC6kpBkW9TRqN1BDuBGWy4Ks7Bh+cUQ2utWch9m83V8MqHpcWuSKh3g6mBtBAd+@vger.kernel.org
X-Gm-Message-State: APuU4Z/S1fsmyOXZIZeibur+9yiD6wp7XGrqCeiI9tTuwA6kGYLg1KsO
	2Z0/KlJIJ+TEAAsWU06SOmZaH4j6Ir39DRM6kkOkHQsKQys7D/mLHlDal/wVBPkenQPzJ+2oj43
	nX+ZlAm9Em272X/Lg2A==
X-Received: from wman14.prod.google.com ([2002:a05:600c:6c4e:b0:4a1:f979:6ce2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5395:b0:4ab:e27d:e241 with SMTP id 5b1f17b1804b1-4bb55a95d09mr284486225e9.15.1794925013551;
 Tue, 17 Nov 2026 06:16:53 -0800 (PST)
Date: Tue, 17 Nov 2026 14:16:52 +0000
In-Reply-To: <20261117001507.1611984-5-dakr@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117001507.1611984-1-dakr@kernel.org> <20261117001507.1611984-5-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117141652.2992350-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 4/5] rust: sync: condvar: use task::schedule_timeout()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, boqun@kernel.org, gary@garyguo.net, 
	lyude@redhat.com, daniel.almeida@collabora.com, work@onurozkan.dev, 
	ojeda@kernel.org, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org, 
	acourbot@nvidia.com, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 17, 2026 at 01:14:45AM +0100, Danilo Krummrich wrote:
> @@ -122,7 +121,11 @@ fn wait_internal<T: ?Sized, B: Backend>(
>      /// [`CondVar::notify_one`] or [`CondVar::notify_all`]. Note that it may also wake up
>      /// spuriously.
>      pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
> -        self.wait_internal(TASK_UNINTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
> +        self.wait_internal(
> +            TASK_UNINTERRUPTIBLE,
> +            guard,
> +            Delta::from_jiffies(task::MAX_SCHEDULE_TIMEOUT),
> +        );
>      }

Now that `CondVar` uses `task::schedule_timeout()`, all remaining uses of
`task::MAX_SCHEDULE_TIMEOUT` wrap it in `Delta::from_jiffies(...)`, so we
could also change `MAX_SCHEDULE_TIMEOUT` itself to `Delta<Jiffy>` (either
if you spin a v4 or as a follow-up). Either way:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
