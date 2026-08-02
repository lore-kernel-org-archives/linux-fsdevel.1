Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EFA3955D3
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785713901; cv=none; b=G0oweipBLbvA4KzCgiRM5fvc2CdiGYer3FTXknFC6lyCIWTbekF+vEqNqlZRZcHsVHmYEunsDNTE0oRn5V3VRKHOexMLko0BacVQXrn4Xrq1be2MDoT7v6YN274Z//V38vbrwTGvjvgxsHxvJQ5f9g4MUdPNcYK/9jSNTpOak8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785713901; c=relaxed/simple;
	bh=+oVivUOlzG4DWDamKxr0o0Y+iC3QIaCQdzJTy/IbOgQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dNZVsdJjec/FrvJd3pGMUgf7p4Df86C/Hxfx+Z8p/wnjWA2FUPGjiy6uGqmOj7iV+izHLNcAu5t2cr/1EXsmmSIUJHj40wO+WS3HY0biu0AEy+GyB+imphNOWvVXvGZLe2TvQESwLGg2biBe/BY+Km66YCRRNjCcCgUKwsbG3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncDq/8MR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncDq/8MR"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf52d15d88so22377855ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785713899; x=1786318699; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WjoUynZVyetLFo7x/yUba6Zt9rYMhRjBHXBxc2twQlQ=;
        b=ncDq/8MRDrw9v5MFEYzSsQ2tcXSf5vGpZC1kyDA/rI3lQYrUbotlqhy/SrSxlb/gYe
         LTnsvnxaIEA0OcielioVaIjkai4qts7Io43QkRZFNuF20K3yxI5pXs4fbUt8JcsmqQg3
         NpCc9WQTVhghAIqkZhweHDvjU+S8Swu+FM79OplWsQIDIc/IqlfXdAVwg60iIRc8GNGn
         pvxA1UldaJ9Na3Wyc35yYzcLuv3mVN8EtZHl1oobiUkpHdRslymcg4z6zwfkdZ+z+cC/
         Onb9X58EevGqvXwElmjY2xWn0MM0MIFFDxkD5t4E76RLIASeQfJwOy/zIWqh7Itg0PgG
         h+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785713899; x=1786318699;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WjoUynZVyetLFo7x/yUba6Zt9rYMhRjBHXBxc2twQlQ=;
        b=VUFV130pMNuHjY5ooma/iAEs5OI8ueypivFWF2nQCJovu1wCkCelB9lhTg0CfUlzt0
         CblroPqSa0C+8Zu3HiQFvkt/4a3NR8fSqFNU5LCaEpeJJFkOk76tQGREpW/7nw/y1ojz
         yOm7+Awt5vn9rub1viagvzKc4rfqSfZZL1wL7pZ6J5kYGhlAiB1Y+KV29OWhyR+ZK3PR
         cH2AqeDNoFc2lviUaP6P6Ut7ApTBQ751R7v4WL5zPqCgI8w9v8cj7qKr2/FVAnHyTjPr
         L+iNXZRdgIFo6UXpiZtykH6YRMnoKSLAgXsZ3iKTcCDUlfWl+4nzkTrdNWNn6yYs1RqW
         ziNA==
X-Gm-Message-State: AOJu0YzSCYfQbdaJyveW1lpOlJJQzbFAtmxqfTZ8IlpjU2kY3uJyBqRT
	wsdnP1DJ5kWLOhmZjAOWhQAiq/tyRdnvbLlQeR7OzODvui57pyThSEVM
X-Gm-Gg: AR+sD12G/mAXXbqdCW9lLHXwg3TgWwlsRgc7uf/hSfHZ7gjZUfIB81eVIodtdILJpLE
	UANuYsgjJf7fA0kOp4o9LPZ6pkOFjeLU5nZXocyE0TxBybW0/wxDqeiuHe1pay/o3VhgeuGbMBe
	2mHGnxaQ4lUW1DO7cdSs0ji5V//Ec4Z7IRzgaqF/jq5l0cEg6u3ktDxjfm611f2PZ4MkENkivrl
	n5KfxzEy8Sc7E3RTXwym7pLLw0Rei2X0AqEPmL6BzUYfU1xcpGMdTGKjv9gJrB9K/zEtk8fPFYt
	DG6Wejq/Lhc6xtU2IKR50E7fo5HX7yrvMvCoiyA85xTfxozrXAiIPnkwfI80UEEHmS9PfF3oTAz
	OsS5Lv6ajj9vqKQ3KAV3wpPm76PUABjRHcHMj2P/kAEXeqmtn0qnH/BH/3WgXx3xNjBPA7YsGb0
	xARy43/nxw4Buqd+MscHsoHW1pWNQQl068YRxI1yHM6C7uID3XcuhRII2ds3vU6AwzDTvUhN1ZO
	Jwvmw==
X-Received: by 2002:a17:90b:56cc:b0:38e:69ae:7148 with SMTP id 98e67ed59e1d1-38fbc4d966amr6898529a91.24.1785713899432;
        Sun, 02 Aug 2026 16:38:19 -0700 (PDT)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4e44bcsm35070094c88.12.2026.08.02.16.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 16:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/9] selftests/exec: let binfmt_flag_supported() return
 a bool
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260730-work-binfmt_misc-preopen-v1-2-4a0b0da71f16@kernel.org>
References: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
 <20260730-work-binfmt_misc-preopen-v1-2-4a0b0da71f16@kernel.org>
Date: Sun, 02 Aug 2026 16:37:58 -0700
Message-Id: <178571387899.1880415.16506772757157668104.b4-review@b4>
X-Mailer: b4 0.15.2

On Thu, 30 Jul 2026 15:34:04 +0200, Christian Brauner <brauner@kernel.org> wrote:
> binfmt_flag_supported() returns 0 when the flag is supported and -1
> when it is not, so every caller reads backwards:
> 
> 	if (binfmt_flag_supported('T'))
> 		SKIP(return, "kernel without the 'T' flag");
> 
> Make it return a bool and flip the callers. errno from a failed probe
> is still set for callers that check it.
> 
> [...]

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
