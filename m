Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641932;
	b=tKqbLLnojVm7djN94QGnNpnKVMPu1TgT1EVxjhxtZ2rLgluFrLreUgQhptBAv/Tn0E8r
	 dsXxo8huze+UxHEBG7WLt6CyOfOeSP/C4GW23ot8zlr4NbnMr1AJ4eJ6D0F8hOswc++E2
	 GexjvhRUjZ5dB7Dv6pdo8DXQ2pzIRjZUU7A1qbj91T8WDJHBohXL+6FjThuYMzAWvmubS
	 MA+M6H6aEOT2YR0D+pPXkGV3T4rlmf8YRXsr4A6M5NN8dSPYwIJ/jGFApt/FFcSlk3goa
	 ItRbp3vkqbNoCfrhz/XTckrVZRHLblSyRPGnM2N0Y7J1CZUJYtbDYmqiasgn2KqgNKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=24/tAy177JKP0owGUloJsJ9O1cxGKyGsp+3cRmkz8Hw=;
	b=LxdEDn//HvV9NCjCcjUL11YaH2triIakiOOpKTN+oU/M+8n3xcsmUoToWsYcif5UpsrV
	 w4EGEfDeanJYEtIOIQCMDpK6RyMJRGT3aObelxJdhcLttUZWxo0g6He6um0ItJ0OZMv0G
	 9UKJ2BP5jEYqAMwzbDrwjeYyf9nBfk+uCmq7/7Wj9lymH700A77O2dRnNPkrm0KxuQsAw
	 /F+/lEqyNh/d9JbwiNVM9JC2EpcTdJYHS7DgFPIdNc8821iGPmUEQMS/Q1I1s1Odcp+ud
	 t01ys5HUbXsx3zAkIfS5egpM2bZX8sgrEuiU8PPa3JHdGEznn7DI0VEmQhODLwd1DvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RI0PEVo8;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940DC606A329
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 21:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 940DC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RI0PEVo8
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb9d8e8e90so34408765e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 13:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641930; x=1796246730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=24/tAy177JKP0owGUloJsJ9O1cxGKyGsp+3cRmkz8Hw=;
        b=RI0PEVo8e/bM5LpLPZ+ED0hsyThViRRY4VFXcvOC3yq8ssab9D3GWTn/NExxaMUXZ/
         SCEfAUzxIznLHW4X8Ux3FmsnGjVl8+Tu2I50vFro4UF290hC+aOGoCx3seQbB/Kkai92
         i2zbpMXrHM1e+hdoZw3s9g8KJwVNLFn1XzFiXMwhZLLCZapmock/E0+9J3LFHctwNKM2
         1wJUObs/t1OyGzg2ZnBNFqAphLTJMLH8yCwqrFBvoaxKN25zrCKYmaShH0vjh09I3jpG
         Uz4nqzrg6/yfBT6SdKciD9tyk2az1dmjbdzWK08Rn0x/RK7kdBz6as33XNA2CJWx8x3B
         BHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641930; x=1796246730;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=24/tAy177JKP0owGUloJsJ9O1cxGKyGsp+3cRmkz8Hw=;
        b=WwqiQ9H4IWvrc8hxg7iJqDha8HEgg5k2h0HT00x/BsuURzfy5YdOFFzpOW8pm84QOB
         R5uNxqKuOUsNUksvHlvUiS1k7mLAMY2seDJmTCEE8se84IwCnYVRHBEvyeOIXXHZQ4SL
         xDl2WUmy//W2EHJxLbfoL0PHY82M/Ex7Tx1lPyqapv2y0B+1sLR6AUnpyx/FidaamXdC
         kGZ/8sK3MfHN3Qfbw26C1Q/cB5XrQvdDdQi2GXKjgCajeZq7UV9T8IlpiBkLwKlgCSzD
         zT6p6YS8Kt3VgDOFAXCcE4qWdAHNrY1LF878onSiQUA3TN2RS0xbEd6Mb0KjYFMUVyi9
         B1IA==
X-Forwarded-Encrypted: i=1; AL+hErFLdquD2vYpntnplHWvSJo7YfFYBiVEN5/PtRb82w+CPy9BafmWAk32Ch57iVXVVCHfLyjEYo+0rBZQv/Nk@vger.kernel.org
X-Gm-Message-State: APuU4Z8EaVS5o63sDntMj6hMDaoZkdRZKBx9L5fW1c5CsNoOxR4GeJox
	M28aSb6z/uIdD/9dHcnd6EaatSEbbBMB/VzyV7A9aihYFQ9JjqCAY++f
X-Gm-Gg: AZFdTZdCB2jjJtYybO9dcg9FgPDQygEavJP25RscpCNo9GWQ1uB2TGVBsOTXpGA7ttw
	vfkEf7bMn9fmHAMyoWkBACWBqetzDSMDogvULl+p6eItnSsU5mnwbp5UN9ZBcgieYXvrZwCrxVw
	IjgRfjowHOBVqtNX8CeTZN1yV8mqrUgLsO27Zg+7FWZeZTXiOJdpUovnbhX064JpKC48fNYmpcF
	KNtaPcTKdSYvcmAMxigQfmy8C7UlICy+GUgFBUQKIdQ+9hMaDU19Kogd6T5rCPARAeX9/s2s9NU
	lKiQLol17OBANO8SjxJMC8ds680RhE/ytBl+XqvHuqA4wVP3YOm2D8oYNv3o4QCoxtdYMGGL6LZ
	P8B3QjOLttsz2MbuW1RcpO5rQ3uOECEeXAyHJcgmkvXyoBLJrAzRi2xKJQSWvdVev98ExDtXqg9
	wrzaBLMN4R4GrtIj74CHw1Sro4659G2e31llakR/OYt8p7DjbfvySHyEv9DTZMSwSzwf+xnOitA
	/+GdinQLrWaEJwX3DUNvfCwnKX4s5mHzfW6mA6q9A6DlcO6XrqymXYz7/0O4BS6MJ6LppHPOQBA
	0IYtXXUN1oUBTbKzvTIR0VP1sbHCkm+4Dyj+SKt4jLPn9WEpg8cbgEfbgcSxlZn4rQ==
X-Received: by 2002:a05:600c:4584:b0:4bb:5de1:e90f with SMTP id 5b1f17b1804b1-4bb88819bcdmr380720815e9.31.1795641929874;
        Wed, 25 Nov 2026 13:25:29 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm615777065e9.14.2026.11.25.13.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:25:29 -0800 (PST)
Date: Wed, 25 Nov 2026 21:25:28 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Samuel Wu <wusamuel@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin
 <atomlin@atomlin.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-modules@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
Message-ID: <20261125212528.239ab6bf@pumpkin>
In-Reply-To: <0c2e606e-e0b8-4466-b9dd-4db14cc35d1d@suse.com>
References: <20261113221248.3535369-11-wusamuel@google.com>
	<20261113221248.3535369-13-wusamuel@google.com>
	<0c2e606e-e0b8-4466-b9dd-4db14cc35d1d@suse.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Nov 2026 17:45:36 +0100
Petr Pavlu <petr.pavlu@suse.com> wrote:

> On 11/13/26 11:12 PM, Samuel Wu wrote:
> > KALLSYMS_QUERY_BY_NAME, added later in this series, needs to find a
> > symbol name or prefix across module symbols in one pass.
> > module_get_kallsym() walks the module list from the head and runs an
> > export bsearch() for every symbol index.
> > 
> > Add module_kallsyms_find_name(), and put the shared query struct in
> > linux/kallsyms.h, so we have a more efficient linear walk.
> > 
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> > [...]
> > diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> > index 1ff8ce857d92..72006c9bad42 100644
> > --- a/kernel/module/kallsyms.c
> > +++ b/kernel/module/kallsyms.c
> > @@ -406,6 +406,63 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> >  	return -ERANGE;
> >  }
> >  
> > +/**
> > + * module_kallsyms_find_name - Find a module symbol by name or prefix
> > + * @symnum: in: index to start at; out: index of the match. The index
> > + *          counts the symbols of the searched modules in list order.
> > + * @q: name query; if @q->modname is set, only that module is searched
> > + * @value: set to the symbol address
> > + * @name: set to the symbol name (KSYM_NAME_LEN bytes)
> > + * @module_name: set to the module name (MODULE_NAME_LEN bytes)
> > + *
> > + * Undefined (SHN_UNDEF) symbols are skipped.
> > + *
> > + * Return: 0 on a match, or -ENOENT.
> > + */
> > +int module_kallsyms_find_name(unsigned int *symnum,
> > +			      const struct kallsyms_name_query *q,
> > +			      unsigned long *value, char *name,
> > +			      char *module_name)  
> 
> Nit: kernel/module/kallsyms.c already contains a zoo of lookup functions
> with similar names. Adding module_kallsyms_find_name() adds more to the
> confusion, being similar to module_kallsyms_lookup_name() and
> find_kallsyms_symbol_value().

I've thought of splitting the file in two.
Separating the core symbol table functions from the /proc/kallsyms code.
Might help here as well.
The cut goes just above the extra structure the /proc code uses.
Three functions have to be made non-static, none are that internal.

David

> 
> I suggest calling it module_kallsyms_query_name() to match the
> kallsyms_name_query parameter and to express that this is a structured
> query, as opposed to a simple by-name lookup. It might be a good idea to
> similarly stick to "query" instead of "find" in kernel/kallsyms.c.
> 
> Otherwise, this looks ok to me from the modules perspective. Feel free
> to add:
> 
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> 

