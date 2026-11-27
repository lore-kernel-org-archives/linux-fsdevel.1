Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745352;
	b=KlIJHzNZMUDmOIuBJogAY6F2F4c47EnxUvjYSsJ7ZmIXl7qGmLD5McTLCDxanDKtsXF8
	 MS2fTWvlJ+FHQLQlYm0tmHAcpBXYInj/EEQSIcGZuEOH2oTXXTjIxSFWLKwtRkCWyGGG7
	 PdyBkqUBQ+VF8oIJ6pnat6rPceg/SxVMVdf8/ImyLTFKiOYyn96eC4rt+2KshxJrbQZVX
	 luvhQRsx7613IlMGEhLHzUJ3OMO71aSyVAzwKdRwH6jd0Hetfitj3xyheERmXhC36PLZI
	 Gl9DB/SrRqkm5bG4SfrclFItkM+3vOC+sAijVx9ut1kMW7MMA+IafUEIyHBolx1Hq9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TeoLwB/UDQ9Aq2ltKnBve8A7vn7QHHpVQfatBUUUiHM=;
	b=LAuxroiybPi53kUAgIPaed6lntcHVhcoEokaJ07hZOOY/qd5aDYWYd+dLXeCenQ1w5a4
	 4lOJSnnfeYxgVXnLGxHowQfVU2NNREND2FRP3wCcasnxaUIVVNKTjpkMsWcPzNhfj27Yg
	 zyQRJaPm6IdPCN0hJLBfO/Ccp0H0LS5Mn3zagUtsrrvw7iwH0ECARu7f7uCOahRrbM3sS
	 rkoOPaZKNZB3WOPexg4GM7CYru+1BgZPVcq43MoO+KxTVJ0eRfSYd64Te+RDGkL3tLdMf
	 ngPecicJebb841Y8yBPwqKWE631sYzbcFzeyuqFJo7kU+Qp/7/eybf63VavYzIytICw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RNC4Ut4d;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD6E606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 02:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AD6E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RNC4Ut4d
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso76526085e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 18:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795745351; x=1796350151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TeoLwB/UDQ9Aq2ltKnBve8A7vn7QHHpVQfatBUUUiHM=;
        b=RNC4Ut4dDjREk+tF0RF4bt027lPbbbviyWu8pyVI6heo0h3M9zRAXClBQ1jFW+UFlN
         8b9YQvW6JtgYVkXQlYAr5gUS2zksACIBXb2DBk7sF3vaXnJynduqAatmZ6VTUNaiUYpT
         pjRrbU+F4Zdf+LHRYxN+6fodFCSjC0dk7DZ4V/2NRBTFtuhVgcSqzgWnjt9bD2TMQyKU
         7y+GbHBaW9wTnuXe3tO607XzJtIxD+0KSshxl/vMAL20/KZxN312/u6HNF+66prlRtl5
         uilvkn5im6BWkhxVCptHOW4zTeiEWvdZeQM0LawBuTzpR8Pl2gJiU7fqIEGwdMRwpNui
         dc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795745351; x=1796350151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TeoLwB/UDQ9Aq2ltKnBve8A7vn7QHHpVQfatBUUUiHM=;
        b=WdbzUNVQGxkTrFUkUw5t6K5wkZc0e+GyMSnlBRQYqCAvbKjykgB3qc+T9IeV1QtUgK
         1HjLAXJii5tilSN4/mepXXdrwI7aICNgzLysxEr7ErKqg8RWbTHcKtD3AJ5vREM88K9I
         827lQtFrQXCwYxtuSFubajsdl76nioGh80hGJtibE4LlbI+NAbWU+3ax5UnEKcigmo51
         MmQSKgH+C+bGYPplTj32zyd2xjxB8jWl0FFeheBthVJv9FZmqS9+Cpwc6ja+oQkJCZXt
         C38mBFp1Ke5IHjH5VRy+N7YeBaTyv2q0lDC0CUQmw9vT8cBYtmasFIs56IFgwAs9axJq
         x3yQ==
X-Forwarded-Encrypted: i=1; AL+hErFhUM+6wQudnz2LV2ZaD0lSIFP5VPrc/XaBUdHWGPaGNo6d7rHcSgVLcHg6UxqDT0mruNZs+kibs43CHStF@vger.kernel.org
X-Gm-Message-State: APuU4Z93MgdQSK/4Qfu4o3RDqpKuWFitefnMRMTdiPuvy2qWhQN6isji
	+F/81uLepbJAW37q06ycoLyao1Swh3+1o1eury9NsA2g2bkmaywlwGc9
X-Gm-Gg: AZFdTZftBLsu80uCh3pu1L+yEk4kjCiz1xPffWUnU84fpIRDE+v5oRNHNSLYWcef9hu
	xeC65+S+lvoU/qZ6/fGYeZUqfP/nxgvw5WRP/4RCZ5QgKaPSsvf2OgjfbuLaJspvGWNQrCvCewI
	W1tGIj8olzfvveQzRP22SzzEgcHp0J+kbDNAZqGyBXWfU46iSSe8Iv526U5VBBTHd+yeK19CpBX
	h0qZn54T2ATw474LPqWdDiDZhbchCX97HPpzUZ+GUudYhAQ40zkNmiJ2uqPkhs5G5Vbh70NtzaC
	BAblzbgMw6/hil/XY6AtTB6tBWk4AbpFdF4ihM4BY2kWFGlNL7nfKj9pGFv1++2QfbvZl/h5LH9
	kAkgtHjbXjpbuFajkttSUtu6bkwqRWGJANzXH9nKA9w/mYUisCfOFle2rYNRP166krR5vpp37Ss
	HSY43F7HBHnUSnavmmsvh7PqXLvyCRYLe9k9uIdBBoWA0osmhE7xdbtBkL/cH6IeBM0iUTJXed4
	/SkhmEKRCM+XTXSfX7KOTt+vIq8glfhGLBQ9A/b3J6ZbTluih2RrSYVhLheIv03c0Qf17CTAn5h
	jtYQb/EoEBauMXiycN/7nWlGTg==
X-Received: by 2002:a05:600c:3b1d:b0:4bb:6991:2330 with SMTP id 5b1f17b1804b1-4bb8881a890mr469097755e9.22.1795745350705;
        Thu, 26 Nov 2026 18:09:10 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6a680355sm36421131f8f.27.2026.11.26.18.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 18:09:10 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: josef@toxicpanda.com
Cc: James.Bottomley@HansenPartnership.com,
	andrew@amutable.com,
	brauner@kernel.org,
	jbingham@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sergeh@kernel.org,
	taherafahimi@linux.microsoft.com
Subject: Re: [PATCH RFC v3 24/90] cells: add the cell object and cell_create()
Date: Fri, 27 Nov 2026 05:09:01 +0300
Message-ID: <20261127020901.3649055-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-b4-cells-v3-24-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-24-bc9095937a84@toxicpanda.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Josef Bacik <josef@toxicpanda.com>:
> +	char			hostname[__NEW_UTS_LEN + 1];

Okay, so "hostname" is present in cell struct, and I don't like this.

As well as I understand, this field is only used during configuration phase.
When cell actually running, hostname is present in both struct cell and
in actual UTS namespace. This confuses both people and LLMs, and invites
for bugs.

It is possible there are other fields in cell struct with similar properties.

So, I think we should do something similar to what we do in fsopen/fsmount:
separate configuration context and actual cell. At least in kernel.
And possibly even in UAPI. At very least, please, fill "hostname" with zeroes
when cell is actually created.

It is possible that what I said applies to other fields in "Slots." section,
too.

I already said previously that "root" field can be recalculated-as-needed
using topmost_overmount. Also I already said that "exit_status" should
be delivered using usual "waitid" mechanism.

So, it is quite possible that whole cell struct is not needed at all, and
we should replace it with some kind of configuration context, and when
cell actually starts, then that configuration context should be deleted
and replaced by usual struct user_namespace.

-- 
Askar Safin
