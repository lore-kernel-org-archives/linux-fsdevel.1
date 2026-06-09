Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72D359A65
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016527; cv=pass; b=ONccq+0BA72df6F/vAnS5/M+lnv2RTt7pNzV0rijpEgcHX4DtfnzWLnJI+uGtkZBoJU/V9qxG3AZrYttEgH4S4SobfLUB8Qcws3xGLpRUQHWvG5u9j2eiijd0PLQXToD9ZtLAJoxw8ID5yZJmVRtiWU0I+uD5LDMTc7MT1jvTJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016527; c=relaxed/simple;
	bh=+a76krTz2XmJx/eLQrkwaJT7VfP5qKUf/8ADCJM/SrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tx/r5hXR6kYYTXBI5T4r16rSbnaH8V4xIYH+BCbHql65tTqYBN8WIUuz1SHQBnnCAdZXrDLqCDzOOw8PkIHqBEPugLMBf/Gr01p3dQVjqEllWRgXWbGXAdAte/lKXGcHOURZbuq0DsTIaM14KDISI79beki6IUOodY6vqwgH9SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rDG4dHT5; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rDG4dHT5"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5176096116fso61711941cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 07:48:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781016524; cv=none;
        d=google.com; s=arc-20240605;
        b=IbRIZxTDsDfnnM6bj41eeZAIvF3qmHIN2SDA82jA1XncU2DA8nqnfyr2ibttH4MXM+
         dRD3Is1NkehnqHA3o9hPXp9FLELHTqpmiojyWIrzzevKnwV+nOaLcciWc1RSaL640PiG
         vYimXYpFZjOfsIet7Gj7kWb0ZfBgJpsiIvJbAumQBkrQws/dYY/fsza/9mTFXRorUayr
         /DeMs/dhmq45YIWW6cjlWIbcIkc7LM+Aq2uTYeNXqO6KWqzUAIgxVNjSGk4drQ7+dnhs
         hhLsvZ9flwVTs8bj5QzZELNGzg+ydj8F1oGlxOLlVgen4U8ZN/RU2c3aIpN6yBenmORl
         HISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+a76krTz2XmJx/eLQrkwaJT7VfP5qKUf/8ADCJM/SrI=;
        fh=iPfihKWOxLCqkT+/JifrX+opm41S4BV6tHnBWLssuq0=;
        b=MJ6b+gAia3W/u8ydQPgG7//bouf1x9ScL5Kr+oMYIsMTPg/4kJVOtfr6ffXGYCW4K7
         0HaDS/tgsnX1Uqc3fSQIB6EqZxI2SyhSbEEDlY0IpxnaGpWS+cn5vsxqaplCZcLtP2FM
         9GTbqJJxrbTKIunADzQFQ1oiWGFPTkHQP/UuChk5nT6KpGSNBbvyw6xQ4JBrVYMnEprs
         zIoxwuBVl0T4s3vlJOeCJN0/vEfWFNIob1KeUZWPVb6XbVMMZ1KDJuLEdPOFSzUcJC+x
         HAWsPbjEfydw+fg1ckV8mYi2SZlcGoAp/TDYLcLCdgqP4IVYE0e1FavTur3F3109TbsT
         EF+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781016524; x=1781621324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+a76krTz2XmJx/eLQrkwaJT7VfP5qKUf/8ADCJM/SrI=;
        b=rDG4dHT5AfA2WdvIXAmA7syTkVd21OoP23WLBOYg7dPYDC8V5C5ZPBL70GnqyUaXh+
         08gR4ysRYOvDgmMQ0ntyEl7RpMsWgn3ooc2wlMbNTHNKQBpyMKt09PgFXdfAf3B0bTV+
         F7wlq0VmFPMIlRR48k06seV9UkmHhXkVvf95Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016524; x=1781621324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+a76krTz2XmJx/eLQrkwaJT7VfP5qKUf/8ADCJM/SrI=;
        b=WXx13TWL+MxcJsBnkL9GFp6mSh12ilybg8BT++zpfcwb4XzrgzIJSjKsujA9CiTQTU
         SQSeBr9jiHTDWkpv820/3JbeYq0YJRxpherCcVfH7HX2c03SAyCFoS/fQk79Uj/0GFmp
         wfoq9zwPZUEpupUHlnlReHotnJBCT9kz5xyG+kos8Q1o+O1VWXHLMi8m//cmysVRbsAl
         sHHLlmdn2X+qskg1ADYE6MG9CMV8uJuYmby7rIslYEFWy8zK/eNcHbfPu5rxmwrf0Oy5
         LvvGbR+Pxg/XEydbfx4pKiXsul7W0efDFoytidPYjs7/bXbC+tnWuFRbSoeafwHw6am+
         q19A==
X-Gm-Message-State: AOJu0Ywbc69seQICA1o/szu2Eyl/Eyco2n3wpyg8lS+2SdkOCrIOapPG
	EXd+k59k13RUcTQEA8a/gIcAXaVQLDXAjBzyENVPE1yY8xT+TiXyxsOUrQ+RlaB3TI4mi3mt/eg
	Fyz/noDJePNHQXYeW500vXYvEdwSL4+ragaaF1Us5xCSAQyUdkiwiTWY=
X-Gm-Gg: Acq92OFdzuTSKWhNn899SL/NIPmkWA6ljnO4aCHt2qtUt4BIilE3BcFMYtOLhV1+y3n
	sOuQ0XxPI0PGb7oyLoN8k69LgQYGrNv0txufsp1MccYAQpkF+/9FeLKc1GdDP0hfskQjIYYZ7Wb
	7FhMEVQhuTfHiyu6gKT4AUhAulTsS+PCQ812dPOuDT0fG975NOERKXcYfiPMXER4TKyeG8p9JF4
	SWa0kGXigLcgWyNZnwGiKF6u5VkPAcBrDCXfsqF5uMjur+5embz7IR78u3a5yrzMW7hcP0hjdmw
	PG0dZMRxMoYvGeHE9jzOob6+8DzV05i0VoWc6w7Xk3v8ek5AMwI=
X-Received: by 2002:ac8:5c83:0:b0:50e:6313:6e13 with SMTP id
 d75a77b69052e-51795a829femr290022861cf.5.1781016523708; Tue, 09 Jun 2026
 07:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607175832.14378-1-mahad.ibrahim.dev@gmail.com>
In-Reply-To: <20260607175832.14378-1-mahad.ibrahim.dev@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 9 Jun 2026 16:48:32 +0200
X-Gm-Features: AVVi8CdZ4js0VeRqh_j68vBF2z35GcygI9fU_Ch7SsQ7zhQ_apUd4JjVOTi5BAs
Message-ID: <CAJfpegvi+gnwV1+a_QTSvJ46-4_8LGoAsU=xbqE4J4=m5RU6rw@mail.gmail.com>
Subject: Re: [PATCH] fuse: use min_t() instead of ternary operator
To: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jun 2026 at 19:58, Mahad Ibrahim <mahad.ibrahim.dev@gmail.com> wrote:
>
> Replace existing ternary operators for finding minimum value with min_t
> macro to adhere to kernel coding standards and improve readability.

Doesn't improve readability, on the contrary, it obfuscates the real
meaning (return error or zero).

Thanks,
Miklos
