Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C7471412
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664068; cv=none; b=dtzRXKC47F1ZmAMX7XYaew/a0d5WbXwhs6aCXU9H7eBdPALkvSehe4nAgW6JCu1rnRYaIfFiOpAf91tiShI0WjF2D0V4lTNme6LSn1KxDkUW6TboLN2/Dlhuw2xL5tum4xjx//YTHTzbd/UZdYqxRuo7sdu8o756uN/YzdWOUlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664068; c=relaxed/simple;
	bh=dZXT/FK7+tblCR4etoX/B8DPZXP4pkVpPaPoQ4mCAI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vB3DfiKajBSrOZk99xzqhvxNvIFY1eGaGM3USz92f53zJbXIiHuXoAzHthROBXiONMuKtuXOeUqg4PGo9qaKL875n4AIb3KBGC1d5eLfeLQ67ODpij3dqJwilK8jnVnD+OWWB0lpF7b4FciyLuoYJrENpzpAqYUaY5RLcASSYoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LUpNRjw/; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUpNRjw/"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49808ea1b64so6536275e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787664059; x=1788268859; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/wDF0hN/FW6BAXrcHvW79QxhTrkNJERnJhXR31M87d4=;
        b=LUpNRjw/bDi1PJjzxflotWRksbTiWTYvDgQQ5KG55K3hmqXRo0bT8fo9bHkbgPE4ax
         g5SGSqtCC0FFSxNnCfZzxIT6+dcUPucNZ84l0NtbcxUMJIzzo/MNz7z7ej3E4cJ74+qo
         db0c413lo5dZ+c8gjq7c4AzzeMga7Kt1kEStbViOdwtxf2AsQsjU66RtnOTF56JiOiCh
         3NpQz9LuUb0DEkzW1e/WVKTY8X7HRePmvIH1DvndSuwazDPJ5M65HnPI5c+DpV0luIU8
         YIHHo7GUjL5G5ezhDRr7iScqT9Y4RqZf1wkC/7E87/FBfa3LgoK/FwPgwVlw/KqEZV8p
         Q9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787664059; x=1788268859;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/wDF0hN/FW6BAXrcHvW79QxhTrkNJERnJhXR31M87d4=;
        b=SDNK+UDiaMs6pv7j7WyCLfqoLt/Xsjw6k2/bcp3kF7MlgZZ1t2dEj7nNyNSpoJkdZj
         yS5M9una4p23Tn/11zzef53/rmr4cajpDitRMl5ZnArfEnXlGKAuuEig8bwAiPRMWRe4
         cX9ikek/avgcnHT4hYiySfiYQ/tuyzowaZZhZnnvBWhd8pHRY2SjckgL4ltAdjcMaMHf
         AfMo5deagpeKaHZc9ZdkfXJaaRv/G3YmYCHSxhDhsu2RT4gGMtVUZZ8TZB/oIKPBQHdi
         Xvw+LeLko9jLJjS6yqx2GN9OHtMhH+cFPA+RpJs6U7BbNg9IqtnxAKe47hz7AoqsBEy+
         L7Gg==
X-Forwarded-Encrypted: i=1; AHgh+RqmOAm9IjExfE1bTZ7CZeljd5nVWywLoQfRqekEU9g6UdOcdnaTMhCHZHFM33Whs7Lpn/Pa1llOHhZR3LEj@vger.kernel.org
X-Gm-Message-State: AFuF++n2CF51dHZJk4h+4wm+L1als42MFOUSuSWQsL92BhOvjA8FMACv
	GdSpR07Nsgri7UpdCl/evic6XNFNfGkM8ls6agy2SWYJ3fzSpbtFq5u6mvG3txo2Y+yCFPY3rjM
	dA3gE3yU08WHM8IEpAw==
X-Received: from wmjs24.prod.google.com ([2002:a7b:c398:0:b0:499:9f79:18de])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f89:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-499d63308fbmr60648795e9.6.1787664058484;
 Tue, 25 Aug 2026 06:20:58 -0700 (PDT)
Date: Tue, 25 Aug 2026 13:20:57 +0000
In-Reply-To: <20260824-unique-ref-v20-4-490735672187@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org> <20260824-unique-ref-v20-4-490735672187@kernel.org>
Message-ID: <ao2WubjLtDuHvRzx@google.com>
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`'
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, Lyude Paul <lyude@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Ira Weiny <iweiny@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="utf-8"

On Mon, Aug 24, 2026 at 01:17:56PM +0200, Andreas Hindborg wrote:
> +        // SAFETY: We just successfully allocated a page, so we now have ownership of the newly
> +        // allocated page. We transfer that ownership to the new `Owned<Page>` object.
> +        // Since `Page` is transparent, we can cast the pointer directly.
> +        Ok(unsafe { Owned::from_raw(page.cast()) })

This doesn't satisfy the safety requirements of Owned::from_raw()
because the page may be used with vm_insert_page(), which increments its
refcount and causes it to be shared the vma system, and this occurs
before Page::release() is called.

Alice
