Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD93955C0
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 03:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778644261; cv=pass; b=XXeHnrjPLNm6jxUx78oFJNzLNGDcZ7JP+fySo3FOYMQgrVnDq1uy6IHbMj7L6B0LMlTl9NgkYq0xZXDYpQJQKY1uvcrHJBa/hoox2wCYfvWlk2+ogezHgLD6Aa2lwM4n1Q8nFxmQPXiXWg2uOFtBokvou644X5Gn3CTellzc7lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778644261; c=relaxed/simple;
	bh=ySuOWG4al6XqpgWWhWblWAhEAKrZ0xPYXy7Feh8cyFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfYJON3lKYY+qvljCEK8vY4MJrS6Au7Mzm5uAlL7mDfodaFoBCVnsPZTyF7dxI/RRXHqu+JsNY6gDfXtznQmatdoLGjvTgZK6CN0cI4B+iLdKCjQKHv8rmdjL3pclSRwb77z69Ntimb+6jEpbCwcjDH40MPZtGQPUP1q05GfrcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cR71oiUk; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cR71oiUk"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso42a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 20:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778644256; cv=none;
        d=google.com; s=arc-20240605;
        b=lK9z98dYEEmEWeXR/qE+027eVqIz8aQNk52P/Hsv/1OhJByWltLhdzM7GuOm8dWKWZ
         M5S1Mwr62KHqwW8zeiZliUqpOvwQOKFvFYETaX63ufb1pe9nNTQ4WtAfW8htlnDrg10X
         i/TjTZfiZRl4eR8HTuEVAmj35byaNum0O2QWSZfvVp4qVHkIHUHxVVHjzDNXiUQsIJ9H
         DVEJtcuNud+quv8REwhyZgg9h7cn/UZ2K6TRv+7G0ap8oFP+LbCaFgiC0jYoTwdB860Z
         WyGEkBTnsxexs3BnuLepEZLeFHfysFFMTfRYim97hwARW+Jt40HUEpXBcypPoc+1cYDR
         FVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=55D1DN5rEuWPlm48vc4v77aNlbyIDswld47F/9dkAa8=;
        fh=RVdFqwOPl9+SGCGOkwoKBh2d9u7D0lTMT3SV8WJM+FM=;
        b=Tdl/ueHbfoSFTzDZ3dqo/ozMMhltg/L3oEdiXhOLR0MbmDK5ZnHGUwj+omkMoiJ1Dh
         NiK9+c3C0pE4IiB8pyjjcRGTeGmdRPYADtYV2mtqaiqKiuqtQPDs428CiDSd+n7QBD0n
         iL2oazd/HJnkAMNBSzJXrTq5W+MZ2GEEc2Vqwg9lgleMmUwgmD4/DFWbBDxwp9nCGI4V
         TiCo7+CHJslYHiRQ20rOyEfkWsCTbimK/8D6EwmMxxat+W36atkNcsJh99xqmMZKkaXu
         si1VTQJpMSqP3ZU+6MuZooUIyDR/Ev6RyyqxGjEslYMgVIAACgFt0WZLZ3FnFpg1kOVA
         myFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778644256; x=1779249056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55D1DN5rEuWPlm48vc4v77aNlbyIDswld47F/9dkAa8=;
        b=cR71oiUkwqtCrtEipaBtIFJGV0xPTbiheFEwiUrk1wJ1Yzxl8W/SyOS/D6ykWdxI+f
         baI+bmDXnT7Dl5cV39N9MgcnG3luhSmHIUFZBBZpICReETIyTIZFQ0tuA+7ZKQwL7i3F
         AR4fjq0JKLfS+nPsu7S04673SDtt0bmEKosWGduU4/CDvAdqf1EuZOMJlfVg+3QBDdmK
         +GDXPd60WeJzUE8TQTy8hYu00igZp9tkrkJ7p+A1Uwx+Ol6wwOXY8LSrGdU7+v1+l4vQ
         luTn/RGzlhhBmxIPtHW2+SomVI+os5kbM1FOdBupGafzaDw6VAvt26ho1si+7vLNXmRr
         3lKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778644256; x=1779249056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55D1DN5rEuWPlm48vc4v77aNlbyIDswld47F/9dkAa8=;
        b=PfBcALO7lqAIEW99/7N9a90MLR8PE/dtFnbXMEAH86uAudVh0Du6F5yOFzoWJswUGP
         vYJGzouA8DEUAp0nmbhCgiG39IpSdY6iszB2kH7eoA+Pkc30khyoenU5aIUZju+azu9V
         l/LXNI44e2VA/I4H20dj8t074F4Hla1xZcL9eKTRtibw3efACn+tXXIdcmYqWsIVVYjl
         nSyxOHvhgTqPstNsdDaOKmJQi39sdRjcaA6Jnmq0E26uMoyoWAY2y8YYPS7wfoWywnX7
         rX+IE6cVZM/OyGvPAq+ZNIUiGHHcHWvn59JwhmrnAiIshZCstBraUL8MyjIh1+KRCUC4
         A5eQ==
X-Forwarded-Encrypted: i=1; AFNElJ9knq3CpO7yQNQyXaoEuPhtvJpkqqtZuc59CRPZgE1RrIQvk7ve4VMknv+qGuSCY1sl71NEUcHIXhj4HK00@vger.kernel.org
X-Gm-Message-State: AOJu0YwHIFvJQvSY0i+lU1I3XuTP0pQ/7MnPgyJvf5fW247AZVQXD+a+
	S3QpwvyCuFGok70YLm2pY6A2qVqMKQJPLmK9GxpYauen/Wj/LRu1ixH7PolomO9V5GZKHGa+Ijk
	XXRLuDoN5Pwc4rtL9DJfxrMFPqmoBasTziZnulk/+
X-Gm-Gg: Acq92OFmQDlZ7FlVTr6jU3d3XgTs92DMCP6BFQ/Rvn4d0nQpe4XQjAjLsHmvoUJ437J
	WsLZfpWNpHoh6JDD8w561TPlqKvDzNNeqDXUivQngcFdCFQRUTKRvF0XftZgPMT4YhaTJiEluT4
	eoFVk5oqwQk5dVEncVcN91X71R13Tze3stIEDWFo2hJdWWpllgAiU4aqkly4sHCJQWst9mf0fTq
	IP86hdRySi8OZr7tshRV0PCIk1vcXwKgprNIURKw2hjp2f9qsXpETMsuFWgPap6MestfRUj3D8t
	u+yt2hLUab4QYBg6
X-Received: by 2002:aa7:d785:0:b0:67b:6d1c:9585 with SMTP id
 4fb4d7f45d1cf-68214ba3045mr32613a12.8.1778644255979; Tue, 12 May 2026
 20:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426062718.1238437-1-surenb@google.com> <20260426125941.9921d585e2c5033e68ddb9a1@linux-foundation.org>
In-Reply-To: <20260426125941.9921d585e2c5033e68ddb9a1@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 May 2026 20:50:42 -0700
X-Gm-Features: AVHnY4KooogSc_WOOEscskwK_cvUJBgoIv2moaw-0M_9CqRzzIq_0iRE4kQW2m8
Message-ID: <CAJuCfpE6L8ZRQEBUVx7j_qYQQJB+coVPUMPhOyHc3V_mBLF6cg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] use vma locks for proc/pid/{smaps|numa_maps} reads
To: Andrew Morton <akpm@linux-foundation.org>
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	shuah@kernel.org, hsukrut3@gmail.com, richard.weiyang@gmail.com, 
	reddybalavignesh9979@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 12:59=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sat, 25 Apr 2026 23:27:15 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Use per-vma locks when reading /proc/pid/smaps and /proc/pid/numa_maps
> > similar to /proc/pid/maps to reduce contention on central mmap_lock.
>
> Was the benefit measured/measurable?
>
> Sashiko doesn't like your strchr():
>         https://sashiko.dev/#/patchset/20260426062718.1238437-1-surenb@go=
ogle.com

Sorry, missed your comment earlier.

I think strchr() is fine here and Sashiko did notice that read_page()
always makes sure the buffer ends with a newline character, IOW
*end_pos =3D=3D '\n'. So, once we found this last newline and moved past
it, we terminate the loop. I guess Sashiko is being overprotective...
