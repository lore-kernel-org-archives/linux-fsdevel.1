Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21F4A8FE2
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265992; cv=pass; b=fVrD4vmRwhnSO3keojEr+fikK5W/ozP/HfPceBLQj/WGCIRhBeE3P16Ew9Se2RkEn5rriG3SL+3sB4w37BSfFbRM1rc42TJe5zdHN8rqzclVQalIZu+BIu5yO/WPVuF6B1COovGDxDLvo2Eqnd9i01ORLniUJYyqzXaHL0R5DWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265992; c=relaxed/simple;
	bh=s87PL5rrwrP1hfiGb5q93550+Hv8VMpEJj1mpIiTKCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bG9evnW6F8Q4X+cFFJz7TIkSKH56zpkrwPBPpfUSjp27/8wNYXtXDfaf2TJhKXGtR9jU9/GImxK2dGknoe5icFuGl8xlGARFeJsFVZGD++4AZDNsHI+IzQkr60Gt4kWIF2YEWbv064zEBYZmz9aWLRPFrWKyKs74wR92om7qSE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO48X/LT; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO48X/LT"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-801a8bf8112so1006947a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 09:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790265989; cv=none;
        d=google.com; s=arc-20260327;
        b=TNwahGYFPkzsjUdBOdFvvY8POftk6YbhrAFWrUjTgol2vmgTUJtui10chV8Jc+puPb
         nS3r22iH2nH2+pjfv0E8ISifhipEhPewFMH99G88wIkard6gl1dfo6m3gVXENKPhBwqu
         c4RQ3QuMFuEa6JVjzFPNJ8ojOZ3r5G1fmhW3lES3a6tZDX7IvjULSrHFrFKXivUecifo
         Ko1wGpj8g6FBqQlh3hVw4EYsari43khvk18JRu4lLDH/dpLrNLPxBe4JzLu8r0+yEdTz
         wkT27QkLKvephvFy781jVU2wYfUINyaycuW952EQY8sW5vK0OZi+KLS8Ik1vdXzACQ1S
         0ENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s87PL5rrwrP1hfiGb5q93550+Hv8VMpEJj1mpIiTKCg=;
        fh=DAMvokA61aIFIEWOBMLYQDbfmER/M5jxxfx20IihoTg=;
        b=f/S4y1dhNWpLW1Gb02+6BXGlM3UwwsQT5AYcg5zBqd06TNTZihWqxgBXOjKkrVly1j
         2XKWOu7ErWVppj1KaWL9mUARY/29tDs1YQaBU2j1pMOMKQPn4INVVRUoDnZxFR6FWx3i
         XD/WZGxNKDaEDloEMa7R7ko8ZBTiMHOYi+zqsBFvbWy/3g3Z+MR4mGE6wqeZ1DRoqyTp
         sF6EjMh5fJdcwbcwi+7UgqYm8Keoa9kXWPLsp46Vr2ntZUnmwfZPSHUaAMURr+BoFhLS
         /fvSP5EeaaxArx2S620sAuWA9P6B2crUH58XHyVKavysVXFYUAjfemDllbZ8Bu0tIJEF
         /qlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790265989; x=1790870789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s87PL5rrwrP1hfiGb5q93550+Hv8VMpEJj1mpIiTKCg=;
        b=lO48X/LT9dqCaMQDc1j6i+bWX1ERyN4cgsOxZb01EAFQT7lJvIgxoE6mvSlKj257Nf
         qeM7PP5RtKA0hBoc7oqXzpIFoMlEanm+PGG+Ny1S4LqpvXWa6emxuvUBIr886XUW5IXa
         Limf76gud0UEroF/+cpsKrbYnXF9j57Ugw22XU6OIspFZvrrtJVShEpqrImoumEfJxs7
         UOmE3XoqQEEDeldjagGFPenIWf64el1QpbBRTkcozaFDkXx5RqW4OuQIUAf0TZSxSD57
         RwSoY4jroYCQ7vooDkvz7qOeeqdRylE0lLvERLbTkGDvY5bjd8OEBsEPTbr/U+kpZxs5
         n8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265989; x=1790870789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s87PL5rrwrP1hfiGb5q93550+Hv8VMpEJj1mpIiTKCg=;
        b=LHt2YTdCewq6XquHbEHgVmk6brQZzzuCK+oQkHtBdCOu0ZxEBNzKn9bXH3T4VkzYuo
         YF7qvPaat1R0LA1MX1vAtXyMM8dPn19pusc2dWNe5YrypVXmQO7FWlasTO6pvC1KHujk
         AEvBO/LfLxuG80OM0WOXetG1rKJv4kzG3nvxtVA90rCXl6UixbV0FlQCnsVIsGNFDxGz
         CHZ1FM2pU+IK2eg3mRSidSEvDFKPBk57bt0HGoos5oCk1HuLqEVrxxkeAJmA3UWdinAb
         r+K/x2aqyGrdX0FL/k+iqol9hq0LDqD62XhevByLGkH/tBNMDWq+q9RjsHZfKIeKIiNH
         cXdg==
X-Forwarded-Encrypted: i=1; AKwUvBw6l9P91WvfbyIsUarXxJFPI9tAkogSJybQ6O8XdE8a5XwPZD96L+fsGeFzQ8BwkyRJ9WcwgTrgS95xIDwG@vger.kernel.org
X-Gm-Message-State: AFuF++nhLT1iJbupNFDT2BGpbkfDOND8B/iTCX3xML/931FVOJX9AeQk
	VOy1r9WC5A46ntJoEEjjJEVOWSScRgU5Rh/veeHsM/IsrRvZuROtVOCYfOqr+mw92CVulQngTbQ
	H8NXtSAAh19SacKRy9sLPLeq7SepMeKo=
X-Gm-Gg: AYBFou18qn/Fy4A/2AQA0pN2aZ7aoFO9z4A5chdgnQd/TFX8DrDTf5RAIBv1kjlsGDT
	XS3IFEZGWY0cVNcsOaf+70tdOQEVjzkordkqKSYpBffA80x9zz57VXumo9PUWmC358YzAwMKREg
	p1zkuqS2PkKW0c581GI2zqgR+BsefizBqrslKwDS0abHA3w2AtmvlX1P9FK496b2KQ59UgL3P5T
	rpPNZ8Ib6jjI03g5JfzGwclJR9Ywtn5tSPTYTuHU/UXVepZL1YSgeGV7wR8FgOfTQtyhPY3RAiO
	ZOv67U4OXUkpsH3YwGwaKchx7GLW4aBG8HfKnKAs16hmSfVg3sNad+4u3KUqtXwI++1Hxx+veII
	5zo+FEul5FlZt
X-Received: by 2002:a05:6808:5395:b0:4b9:e5fa:8a11 with SMTP id
 5614622812f47-4d728f2aabbmr2804188b6e.22.1790265989379; Thu, 24 Sep 2026
 09:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923022339.3340694-1-georgeandrout13@gmail.com> <arThye_219ruNbM2@google.com>
In-Reply-To: <arThye_219ruNbM2@google.com>
From: Georgios Androutsopoulos <georgeandrout13@gmail.com>
Date: Thu, 24 Sep 2026 12:06:18 -0400
X-Gm-Features: AclHuK-lOEBKK9dYOS2UY00MWakjMDOvzU7dNK00ORx8tBpC4tNpOn47rwDC-Po
Message-ID: <CAESH5ocJR9SLHcYfusixDmOR-CLce=HTpLxFU7zVQZFPtD9uuA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: file: handle fd table teardown in file
 descriptor APIs
To: Alice Ryhl <aliceryhl@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 4:39=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
> This looks like it should ideally be on the C side instead.

I could move the `NULL` checks into the C helpers in `fs/file.c` that
currently dereference `current->files`. Since this would move the fix
into the VFS code, would it be okay to send this as v3 of this patch?

Best,
George
