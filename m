Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F972E266C
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 03:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778755; cv=none; b=kiWRbKsW8CSMgCSixQlGU8UCSi/y42U4g8JhGnWeVUhRo4y2AuFResHoERxjVZtv2SmCbwTt4zEaJ+APCnSNthC8Ck+4F7g/7Jx/iBdbzXMAFZcH4RkmWy7K7hH+3SUWFQQYutk5qwA1SfiSetxAsCnouALJHOGiUo5oOJpNVOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778755; c=relaxed/simple;
	bh=aTbxwJ0UYRw94tr6osLVIdvUNI6PubaF0vPsD7XB+s4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=mW3btBDqLEHJ26Umk+CSFPH4g/3FYwElS0Eap1PKj6l0prO/qnK324x4Pg1lHo0O42RuUv4+eCtUTYCEXJFEg3Qjdsz8NhQFc0rQtT5XayhAOm9NWumBAJCFxrP3NsYnEd36/RSHUpl4vAH8eI38GDBniuMjSKJDwcTv+IYzK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UF4en8Ws; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF4en8Ws"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so123114a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 20:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784778754; x=1785383554; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FUKG7ICgd+GcU998vdcK6dX06k2jTdeBQRHxEC1Ia7Q=;
        b=UF4en8Ws/+ri4YPBhTICcLywiCl0cLlXMkNeN7DD9FbXpqGy7+lJwdzqnZTQvpFL3b
         yYB5bLGJA17XTC3nMdbuJwSWGWUw0oLSWBQDcyP1O6SHT07Xe38THvYtHweXJwricUo2
         C7c60uLt+eW/v5QnNRPAqhOgv4/mHBRLnV0fRXgPgiXXm+AcuBJnG7fGJzFnnRzCPLiS
         DxN+hpl9j+yy586YLEP0Em0h/6If5pitewTPtxF190rPBvk/h1SkrYI/JEZQ6a7SH7W4
         bii37QJ9KLa6z6V4m+5ismhRV+h7IoT8ChVVWTu5aqNAv9eBjYLuzEJqd2NL6FPnjBR+
         rgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784778754; x=1785383554;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUKG7ICgd+GcU998vdcK6dX06k2jTdeBQRHxEC1Ia7Q=;
        b=fBhKryPsXHkNrMqrcuYvUy/4CUeRA8r3VF7Ukb6UsKzO84POHf0Ae7kWNArXLfKKS2
         MD2/xKLh0PM8gfBur1P4530a/bc/Ovw9qre1xXN/5/chZlihi/eQW2Pc9tZlImtFvlhN
         Jyd2oNo59jWW2cJKkbY0LPF+OxRX9CsGDO5W0HXzU2eNDBItHIzWz+Wg4ojCNmp3mNu+
         1lI1PW1Hi/VhYM5nHzI8ynWT4XRAb42RtTZU96UUMU55LFEBwtVeBF/t5E6MAGCv/vne
         hIhfH48txIwltqH4f1AofyD+fJfke8/zfu0oG7XtCxF0XTVBrz6EECwcuDA6bl9O+vh3
         yvAA==
X-Forwarded-Encrypted: i=1; AHgh+RrK08bLX89LDxR/mpxOmJfZr/cbyv9LjPR4vmhQ/1TafHSIH221bPN7OoAeXQx+A8jEkPoNxDNDLTvVd4Xi@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnP61Nk8ajb7Lqa786b3Um8R8if2gykIsvxQb5xwncJYl+P68
	oTKOQLRYK2cfEjE7y3COSMkSsHqfu7IQnW5weFgrq3/DAG6liLDsH3bbDUYmona7
X-Gm-Gg: AR+sD115jZOl+7kbGO6frtOZuEny0R+WB6e3ZJGTBywoSHz7yFJr6TpTWAs7PTNnrb9
	GdCvdiYrlmoIcamxcHI7YCaAPYlBrYWVL2zjdM7fNWD4g8yHjM0e5lRCmii1AeE4Ln04cAkkIBH
	jlGGEYAw7IHDGkovhQGSxilBi2h8MP/NZhNVxtJgd5HT/RkftNp9BMMOz6/xKbIsYopheNAUwl7
	5eHCtSEtGbWCkjX44l1CbV5W3C7cgt0PSm0XNSQyeksguLj1zKRVTXZX7TQVMs4Ms5GqXqgjl4P
	BY7B4xyVNxN5Ow+7mqqaea4wCtu6FnaSI8ndOTCvyDdtq9MZeUhNQmvTiHDDo/qpCoNdj1NJIou
	Zxl6FnW/lVs3SHlpjQiovqxTgHNNZCFi2GEHJ1AGQTrW9TKUz7SD4kXsaLM2cA87Op1MqP02+V/
	XyH4pshZFt/xAAykhg
X-Received: by 2002:a17:90b:5650:b0:38e:cb1:8ec9 with SMTP id 98e67ed59e1d1-38ec661b520mr1404913a91.42.1784778753914;
        Wed, 22 Jul 2026 20:52:33 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d12f267fdsm11497359c88.0.2026.07.22.20.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/21] binfmt_misc: transparent interpreters and
 PT_INTERP loader substitution
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
Date: Wed, 22 Jul 2026 20:52:07 -0700
Message-Id: <178477872729.254289.15918342296936455606.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 21 Jul 2026 16:13:42 +0200, Christian Brauner <brauner@kernel.org> wrote:
> [...]
>  tools/testing/selftests/exec/loader.bpf.c          |  56 ++++
>  tools/testing/selftests/exec/transparent.bpf.c     |  57 ++++
>  19 files changed, 1823 insertions(+), 303 deletions(-)
> ---
> base-commit: 6cea93ff6fe97df34b63fe94487473e16c73b74b
> change-id: 20260719-work-bpf-binfmt_misc-ptinterp-e6ee99ff6ba8

Started to review (slowly); looks like the first ~10 are mostly NFC / refactor
/ documentation.

This b4 thing is so slick; I want something like this for GitHub now.

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
