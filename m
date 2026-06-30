Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148E5FDA7
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828383; cv=none; b=AmlFay2YO1FkKXx8qP5v3oUaco/yxuxvb85tZx8mpSKOcxllhVkPvMhe0seWdeT5u9uMCFaSwjDt6uwATOnQ9jdtQ8MyVPwHQ6La314dl4LRpSC1ecVQrb2fj9o/s4a+xiOmY5ZhgL5apjI5+K+V/xNqOmYC37v+edq9kySVCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828383; c=relaxed/simple;
	bh=9RlesChkXNpNCNICfvWPtZG3iiqYMidzOqJ1f/DgB4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JSKBUIDJWSTEXIWwg5xeJ6u6M5TxsuMfeGnDodAdTqaXX/hhhoS/q6LCp1bGv15OXUBgHzpi/tl+PzIWWDtV762rGcjVWKZwT7yguMgAQ5F2H8UQhsMH1DrLryCsrjgNkdq9Ij8K4nF3xbHSrtbvgsM4sPYbEG6OZ6A9e7WLXAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=OIov1M6q; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="OIov1M6q"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69de16f5f79so2219971eaf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782828381; x=1783433181; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9RlesChkXNpNCNICfvWPtZG3iiqYMidzOqJ1f/DgB4I=;
        b=OIov1M6qC1sHuvKnWIl0jvF6hqj4/JipCU08IObrp0dozZGOllLoXG+j22/TW/Hko6
         JVQEcRAeXZ8hUMLnlIvb51JvSdqIaR8eiw31hZZXwcaFulpyKmy9ZNEyhubR903GAhXO
         GK2RlHztWQqZKGBw8ZWiOhgyNNHRMNxFvzYjuxpqjvGsmyPGmJo4M8NEQcFnHvjaYVMK
         FTsPIdr8wA30uUSqvGTStk5oT1QRBN73txESl8R1+ESyPv0dT+rphaT3sE3MKK1IDoj+
         C+JdmyD2M+AftLOYwx2/1LQcsHOMgoHshIm3eLMpXyThJ1gEny6SWkJdLm/DrsXT071J
         enww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828381; x=1783433181;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RlesChkXNpNCNICfvWPtZG3iiqYMidzOqJ1f/DgB4I=;
        b=NEj+nN4Rdt+5DuCAgyQBYncSYTlTYfl+5sAQEm0afU8l1Cvb2SKk3hLPXqo4uGIvq2
         zLPfh1gmtpBPSLdA7Hmhx7cA+8S79YNd9tLlaP+0oQy84gfFLQdggGZZWkQC4bGeXHnu
         8vXQjQaxR9iS1xg5qL4u5tPGYilGVJWszVxVqmvVyJMyhBoQsUEsGCWx8Nyp7e51r7q/
         nkk3oQh9o5DoRRym8w6Ltn9Mx/qHja6zMlYZYkAR6/vktg4SEQzOuF0HdTxzwnPaBzno
         3/z3ZHBqcBq6nrwcirlNElqpCLVcgv9sgPN33/M2NyTyTTCNh8vZ2YMm7nETSfQCNvv4
         DUww==
X-Forwarded-Encrypted: i=1; AFNElJ9mIxmPRPyRUd42PkAuPZBE/Vy7dQXemFWl71dfuXsAUiA4ZfC3d5B8Ctv15fEkzqzaDZlYPGl0im1X2JuF@vger.kernel.org
X-Gm-Message-State: AOJu0YyioU1qi0Ma6Mu3cVMo5KOmuumWvF+iKmYe6l3YYU56VEExJN6t
	S7jPVxBMcXJCitYhN898cvPO5gaWSHp8XwexuLyoeeg/gvXaqayHua807yxpFOcftwM=
X-Gm-Gg: AfdE7ckzXVPuYmrIcwLXmLuUFONgvP+3n8/1MrmpoFCwUnVaDKB6dMeyV4pzFjDE5T2
	Id466D/vGb4YSUm6/IMtTEcVFtvFK+xcc1Eky61T3kcpbOO96WpKuVIqUQCJ7S01ecNWcJlW9wU
	jL7xhUUJ2LcJAyT8lT8s0WawtezqpYP+99z5WRK/4KPu/xd3yK+QAlouKn7AyfUhNe4GOdhJ6p2
	MqS4pAswJA71tYNqfUHSrL1v6ubzf3gb9tMSNkFYu8+xXL308/q1VS9/04ykmQ5e6Y32eNKEnJ7
	B7IJNgM64lDjyfeGvWaIxqfrpSlia7RbahDBN51k75D+HXg3kG64bGZNFpomo79eZLyKOnKv7z7
	iJjBIrR+Q7S0RmSF+/GhsdUcc12/OntdAzHsPoBElQXu4IdgE7tujCL3ScTfMufPZJfgGiB6Elc
	K/7KwcENLA4p1kIWYrgvkCEom05t/EGbxgBdvlKDMM1ndDxogGBeGHQi688hdaMn2PuBfsJ2kcS
	luYPWmowrKus5xmwEvCm5YCwhCkMCw7eASO+pwrf9XgGuDOxZC/bQ3FOzA8Y7cJum1B2Xm6xzrU
	92/Xm2w=
X-Received: by 2002:a05:6820:1518:b0:6a1:45d8:9dc7 with SMTP id 006d021491bc7-6a18902e694mr2872040eaf.12.1782828381158;
        Tue, 30 Jun 2026 07:06:21 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a189428fcasm1976054eaf.11.2026.06.30.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:06:20 -0700 (PDT)
Message-ID: <4ef15f553f01e959209273f5a170288af6ecdc91.camel@dubeyko.com>
Subject: Re: [Linux Kernel Bug] INFO: task hung in hfsplus_write_inode
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Jiaming Zhang <r772577952@gmail.com>, frank.li@vivo.com, 
	glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Date: Tue, 30 Jun 2026 07:06:18 -0700
In-Reply-To: <CANypQFb_2TqKGrztAXj5m0_v+QChxXDnQVeifzV8J25Vuju10Q@mail.gmail.com>
References: 
	<CANypQFb_2TqKGrztAXj5m0_v+QChxXDnQVeifzV8J25Vuju10Q@mail.gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-25 at 16:53 +0800, Jiaming Zhang wrote:
>=20

<skipped>

>=20
> If this solution is acceptable, we are happy to submit a patch.
>=20

If you believe that you have a fix of the issue, then, please, send the
formal patch for review.

Thanks,
Slava.
