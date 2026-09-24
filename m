Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE7370D6B
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259569; cv=none; b=AJzj3fAihY+oU6RPmNOHPmwA8m8ZphlRZikn4Qx7w+t6jecqg7cSwsBaZ2I1RIEuy8+9j7U1cFYr6temRUsypWXfW7Ct0z6BsqpTz2qAHDd91PfbV4/6f5E6k/zpbY1cF304OGJU0B1uEn1duI9opmbILTJ5leB/X05EvRKDwLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259569; c=relaxed/simple;
	bh=TWdASb3MyAf7mGzhM1GabLO0eutszFmZKdYoyrSrb/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXBI5oN3nAbC3p8OzAiM/9RgUeVvRQJ9gCqHbwumMPCwKUAIzyZ6+rM4s4yPFsVz1IvrlYHm3e2lw3RdLecc0BT8g1E7DZbeS5V5fkWDlqWNhJssnYg/rt3q/mGwgdXPsxZjHVE0ojJLYZjLNYFNDi8dI0hDVPDOvUFaza+w/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=xUsYOoK3; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="xUsYOoK3"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace58so71439eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 07:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790259565; x=1790864365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l5t+RkrxBW/tPG0f8s8vACvjj/UzJW53i35clI9VtqY=;
        b=xUsYOoK3GAHlCcY3Apa/Z4b/UYuwhAOdAh4pYHuimBtUMwFObIHfZeSd8GtmaKBqyh
         VNScnMR2fSPIqEpCCsYjigBiLXBr3g1EaT0YYmCUJ4KugsX006BE9dQJ47nv65UnYuGd
         9sjuAXkibl6VRbaC70Z9QvL9h5eTrdkmTQvuNMfN5fYSNJgMJHRE93sGNB2ht3MowNpV
         Suq0BxBNGDyVxFPwsC7EovxYj9CmxjJds6rXnn123huZXZcJItEZV6HJZgxfykBJaFFQ
         kSUADyZ8D5ee3nUtzdtxg/8ktkfurjEmH0H0PaUUuonLrNto10o8WGMyGdjPXsR2ITdv
         cHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790259565; x=1790864365;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l5t+RkrxBW/tPG0f8s8vACvjj/UzJW53i35clI9VtqY=;
        b=IhPAHlz5JBrR4e39luEXqXE4jh6/5OAkqP5RL9QsYpLrTgG1FMYTKaAQQ2TT9Dw/6O
         nArQpNXJd7ktaIekf/vLXs3z1/gmxbjfx7LLOWhKEfhZAE/6746UzT9OFRZnDZf8QsV+
         3KYMWdgcjzZmydEHF9QGNrFTjuTpvK852WiwOqsrD+17nb0MqZHm4U/iLtl3DWQRwgsj
         Yiv5KvYrydXj+nVuVLkAyHu9WFkT3SgV3MfQtK24gDMPQ1iPNdLlqRMO8jFQ/eZjfdZ3
         EDvlwLlwCGVSecqwT9u3ZzMNR6hU34F1Z1sMnUFv26kpOZnhH4o1yMheoYfoyyCJQ7T1
         I5xg==
X-Forwarded-Encrypted: i=1; AKwUvBxWKchd6E0HbK3Gh9Y3sogvxcnBkngwnrOD6kOsCOu1z2uJryrqPiXDEWk02Y821VzNbOjkOMdwHAvWx9MO@vger.kernel.org
X-Gm-Message-State: AFuF++kxG1Kyylif4dSXr7+E2V8cZQGo1AV9IZg9f4nV95Sh1Vph3Jek
	tVVQdCXctT/Wtj7Jfjbvv0NHgQp6cezrW5QAhkEzhcgFqTE1VflSg1pRdD3FZ3ZHL3M=
X-Gm-Gg: AYBFou2gWTuINi6TqVzHB9lSQlMoQw7BQdV3ZGr3mL0m5cinBvkkClnyJCLXUytK89y
	LCvfXirZvXxGGCFn7thUFiRpcOGTzY1KCfuSDTO+rkhqqZcEPg6muto/kOJBrKXfhR5Gq8U+SFO
	oDP+E6rkacnD2rATtilg3iMmtlUV6J6wtEi0OHy7uqbjNbvzyDjUSiSdn/0Yrl1ZLGSkvKyZS5L
	SM8kNz0ds8FOu42JAXcgjw1A6RLs+2HhF58KuKTiBWTqdWCkM6eRguYKU9rZiWJAetDCiAEr+qv
	51cLPjRcs4AtN+95e3palcG29jRrMUMS87Fshxv+hqHd7K4l7kP6an50lQCWoW6D/cFf7XIIsgL
	ylb7B2JOD6YYq7uxvHXB9dexeMdL6e6CtAWc4id1aBr1+FmICHSCeL/oXEnKLYyHwwSaznsJ4Ql
	iDNySkQYOFrjCIG1l0CfvpK4XzbA0tFeobBVQcH+lq0eJ9BajZAXh+tjLUYypWQLpmVEPQn8Q7f
	C38UHpGPIyLjfLPjn2YPTPNn5/Zea2dn6MGMVNT9X1tYxEeEU+SK45QOg==
X-Received: by 2002:a05:693c:87c7:20b0:33b:f566:eca9 with SMTP id 5a478bee46e88-34001c1401fmr2175061eec.11.1790259563746;
        Thu, 24 Sep 2026 07:19:23 -0700 (PDT)
Received: from [192.168.1.125] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9684ed70sm12529265eec.19.2026.09.24.07.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 07:19:23 -0700 (PDT)
Message-ID: <e1fb70aa-cc4c-4ed5-809a-e8babd52dacf@kernel.dk>
Date: Thu, 24 Sep 2026 08:19:22 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/17] exec: cancel io_uring requests before
 de_thread()
To: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 io-uring@vger.kernel.org, stable@vger.kernel.org
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
 <20260921-work-coredump-fixes-v3-12-8e4adb1619e6@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260921-work-coredump-fixes-v3-12-8e4adb1619e6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/26 7:45 AM, Christian Brauner wrote:
> begin_new_exec() cancels the exec'ing thread's io_uring requests after
> de_thread() made it the only thread in the thread-group. Now
> io_uring_task_cancel() runs task work after. If it runs a
> create_worker_cb() item then a io-wq queued on the thread before the
> exec creates a new io-wq worker thread.
> 
> Said thread joins the thread-group which de_thread() just took down. The
> io-iwq sticks around until it notices that its workqueue is dying. But
> code after de_thread() relies on being single-threaded.
> 
> Move io_uring_task_cancel() before de_thread() but behind the point of
> no return. Any worker created during task work run from
> io_uring_task_cancel() is just a sibling thread that de_thread() will
> take down and reap.
> 
> Once io_uring_task_cancel() returned the thread has neither a task
> context nor a workqueue left so nothing can add a thread behind
> de_thread()'s back anymore.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

