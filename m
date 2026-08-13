Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA8374A11
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638156; cv=pass; b=mwoAotLNLQiguvGvrrONUOP+YUSZI4f/gNayh8DyZUBqIQB4Mjg4T4uqr6WAYVHiJoKWISEC6zor4zBtcIzIezKnlOcIxCe9DT9r9TP5rsN78dPrgE0nYhwe6ZbiDaIvflyKvoeaJrM8btYkGq7a70zwP6LndEbv1vXAbwN5vLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638156; c=relaxed/simple;
	bh=1M8jeBf9OledPwCo3Y9KJxbjSgLkY7istZbzV+oE5wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHWYQtzLqw4RXkEnoAQ6NdtD9uGieFlTKC+ll4A86WeIShCds+iX8Tv/fQ/NhiPeV2tWxVrT7JsKzAZ9OK8Xg8Zdh8yBnM5jv12j1NapLYHw0UQ7jszVLLiJBzXSsSMAh0+T90ls8wXOM6E/CxW9MvpO0eTwcxf5tetQDQbRT3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHwa5Ehy; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHwa5Ehy"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15b1da6b82so14311566b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 09:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786638153; cv=none;
        d=google.com; s=arc-20260327;
        b=sS0qIJiN0dSoGvZm1JLh6Jd+Sl5FV/wdfZn11ENCc9ws1Mjvu4OlS8VKR5hf+KE/QE
         JU9QxngvJI4YkvpZrHHAk1JOStdmM+YAKw7h2ijO3lFvOUE5fhWLzgylKdoR8tJM3nV9
         JITRhXXccOIe6Zq/q4Ka7YSHNvqu2J+UnnCN8Fm+xdDBgL/6fmrsVcerslfOd1bLOxmY
         dLYckUCylo8OkDtLTshAoBlkQAooE5lz+emczqfVGfRoYYvOV30opcsLK9eLgsZ+0SKY
         mdQ83+kNDqX96xBzdHXvOcU3C1jFG/ybxB4nMLmxSvi6FAJQo+yDwDQro9CYdg0BzhFC
         POrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1M8jeBf9OledPwCo3Y9KJxbjSgLkY7istZbzV+oE5wU=;
        fh=zvp3Az04J5/Wocanxsf8yDLNG8g/K/6HXWbpXKh7eOQ=;
        b=kp+1icvhDs3eYR8ZFP7Q0AwH3lqc9441OFEIp5UgOJ+m1Q0zt7ABlay3ya3qjvwMw6
         dcg75f8Dqt5Z4Nwdu1KE0vZdmI3ZHEhsKyCpr9YvMf02QEgLxaVb+vs1kr9X1SVxpghZ
         frUljYU8cS/QGZ6dr2VLS1vI+k2EPZ4GEFOH+oCvfHHGUkhNBX1bb/LGcOiX7vJMknV7
         bF8Ha8AcfC6MzCMKpP/Eu6Kuvg5LqredrqOuMBd8m2KDLB+znMxfWW8a9UzNFuJomWgv
         tcB5JzsTG8M7eDvDdEpoDV2eUrGh4KaZP1c16SKEGVH2HkOYW5z1yfjZWfh4AYQv0NcH
         IpNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786638153; x=1787242953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1M8jeBf9OledPwCo3Y9KJxbjSgLkY7istZbzV+oE5wU=;
        b=MHwa5EhyAM0FaofYtdtvdQmpjJlo4IjQ0k2b7mFsPVZYU02s4f61/247GH0mX4Jpqx
         csN1GZ7sRrBTOWfdhMG1DLF+6MTh8hNZY9KhlEzbJ5+9g2AbAmLF3OiyaeORy+7sNCgc
         A8gTdVSuzmt7FLGJjCJ3eMlrmEq6abM+Tk5xTUNb4x0U5LqCSKjwe7ndX2oesacwYnCB
         TmsLuNKVqYwwHVC2z+6ZYt/ytjnJV4vbr45HxJl1B4ceShpJsi2XuvZXsanjatW1WWol
         J75Q8gOmFe0Y0BDOilP/F20vjQJxc3pZOoNBByabjt+R23/2I/dkVzWr9TwLiQjC0hYX
         3+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786638153; x=1787242953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1M8jeBf9OledPwCo3Y9KJxbjSgLkY7istZbzV+oE5wU=;
        b=NH2QDrYh2yhetgvWIqjCLJQXDfd4rG7v64F6ORR/qf5gP8PfC9Oqxkkk4CicZ/zvTT
         rbnC4Zf4MfwBSW9BvGY7cUM9xLxtWXTyCuabF/h1WxR+7LHPBxbholA73i5eyIxlN6oA
         f3Oe474aqENe2T3bhxGuuHalr7XbhZmPKBhVif4VplHNqQuQTLEBgEbJbpkIMV4RdHai
         QWiaRJ6Ny8KBo8+Om0McNQr/mC174zoPYcRcIoPsppNs8JEfcKF6TUH7nH4LXCEcrYDp
         xA3cvTkg8jxmiSr8+4yHi0JtOj8fdOkndEfxRXsMDD2hbMz0+EH0aiLKe/tbP//3pHSW
         M77w==
X-Forwarded-Encrypted: i=1; AHgh+Roog0fX+Aki/svcv1UVe4a0Sfdh8CaHNuKDr4bOrGV8ojFYlhK5uSM0R609yPo7H3F/y53HfbIXTV/8eFMN@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyOEvlDUTMjB9t8sZEvVytjOtqa/VTPx0taAE+kX0go3VG5ij
	ca5b0pOQozx+MT+dacLVib6DvMEBl5OQk0g28VSdYpuMLOucGB/PxrfYBZ06H7S6+ErVYwjMxnM
	RnO0zoXF5dOu1LEMWTc/GUd5/BoNUmtM=
X-Gm-Gg: AR+sD13ZQvp9ZPWwQd+wER9l2Kjlf0PuYzNjMv5n4WlnxizKX6R+RlWWtGpR6aln/Hb
	taPE4Icurg6jQUWPznvQrFguRYxNvIf6BBTtBKTKk0OIfoelNmJysCrQZ6JS4sZ+0Gi+/+SWq7G
	yXXVzrTdNxYkeTPqZTQK4CXUjB4XOzIy2zFbwPyRD1oUEh6mH0Nto6t/53g3JIg7yao1KHLpiiy
	iRN4xlvFo/sxAQ+Dm9S59M4dpHWgJ2H/mXyuMpr2TXn+OHqjTctVGsVKpbb1xaUJxZQqNc9KEbd
	792CfwJbgnP2k1PMH0MpfFWpgFu4d+bvAikh5CEuQ4SyCQYvqKNyrNBiHLYqU4UizzpbDvZs3Vv
	ovQxNSREShlQ=
X-Received: by 2002:a17:907:6d09:b0:c1f:5d05:34e8 with SMTP id
 a640c23a62f3a-c2108f7bc09mr325616666b.21.1786638152717; Thu, 13 Aug 2026
 09:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721103514.2716-1-aditya.ansh182@gmail.com> <20260721103514.2716-3-aditya.ansh182@gmail.com>
In-Reply-To: <20260721103514.2716-3-aditya.ansh182@gmail.com>
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Date: Thu, 13 Aug 2026 21:52:21 +0530
X-Gm-Features: AUfX_mzTIFv3kEMCf1avXYJ4M3WnrdtRtdhFOhLgeyhOjheLZR_On8grlkxDpyo
Message-ID: <CAK5ssPPMbH7oNTaA_iHM5_Az41LnmMTwGwZEMhkGpzCGF1uk1A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] io_uring: add fremovexattr and flistxattr support
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 4:06=E2=80=AFPM Aditya Prakash Srivastava
<aditya.ansh182@gmail.com> wrote:
>
> Add support for IORING_OP_FREMOVEXATTR and IORING_OP_FLISTXATTR. This
> enables xattr listing and removal operations to be executed in an
> asynchronous fashion.
>

Hi,

Checking if there is any feedback/concern that needs to be
addressed with this patch?

Regards,
Aditya
