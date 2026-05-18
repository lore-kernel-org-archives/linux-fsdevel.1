Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6447B481FDD
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122130; cv=none; b=cN44RI6QBDQGqp4m4qIjIPR/IAMFxAhc+vsOSCIVZf0LpTZTmHx0EhLqZwVMfumcxvMCKfi0iIuw6x6LKHAq8xkdPtbCQUBWilZcjJbDC7vybtUUEbsOJmnm1/qk3KsKoc4wYOOFuBvakpshx3IeZVhr+tk0y4Whj9MaR+i8f8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122130; c=relaxed/simple;
	bh=lADZGL1l+uV+dRUhIFGvk44P/1X//TbM0Q/BhApFkWk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RUqyxh5fTRZjUpBiH/f2irWqP1tV03fwdhLhyBd26FImvKwGxGBnUpg7YsOaNJ2GMJwtL4Y0NRKH09QobqJiYkFcwy+ViU0tUyU6bBoNV+Dii1b9jIRcsv6oKNxr6E1VcGec0JaRF0U8xLjgdvDkrVGa6d+pnkwy2EoeQ9naLnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=seXqiink; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="seXqiink"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso995e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779122126; x=1779726926; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6RI1o8QPT8hiZuDRhk2bWs7AEZtLDRZKqnNbFswNzg=;
        b=seXqiinkpUmksbB7slzxfwbJTHfuUtmJSJ+WK8sSje+0Y53vgfVPO4ny5z11hEHabh
         HOGX/piPC074psVJNXl18wAlXSEFk2+AYZ51Lh02aaHZ6latauUCG9SoLEYRiTWaTJZ9
         uj+N5tOC4vc7qXP4ABS3RD4NkuN3HxJjVfS45hU5pqfSihPsAH4qBUrSWZla924z+QNN
         g4FUM+oScM6YGHlI7to/Eli9f6K1HkdKCuEojME2NUI02duaGS1iTPt975jotYzeDi5s
         QxcPFSW+WVb3T+BCS+v1sOh2VzHw809FwNJnbWTSm5OKLHkJIRMUq1vtiqxQafqli/dz
         +xsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122126; x=1779726926;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6RI1o8QPT8hiZuDRhk2bWs7AEZtLDRZKqnNbFswNzg=;
        b=LrZmf3CKqF/e5WYondBzbd1/BlB3ls/iCNlm2kiWEdDTVFineuQV6R4E6RkB8GDkJY
         7u2yWlgsYh6AMPeg6IJjMJ76L93Rv03t3QpgfovfRq3SJsifV/VJiYw41O+hK4e9g8P/
         X4LRsS7kpt8UhNA2sforsOrVOHZvU4NC+pbQSgGW7TtUrCvgGRF1lm4knr5wKzViPBZQ
         L1T37fDIljtO5Hs+BfAz5uH95cbQRv4bVXnisqmQFnBEe7pfBMa6nEhbZIVg4JZzFYZP
         KSXs0frBzRD1aPfp1tuFcGVv7FVAY3041Ji4JSM8wCLDZgFPmBQXaSBm85suD/MzDsX7
         7Ubw==
X-Forwarded-Encrypted: i=1; AFNElJ8FeL71fPlDrTIrOVdzMrgGHHOAQDBkyrmA1q5zg4s/yQdT82amuyz8uX7ufPoqlTI0pIfdSyw48Pobvp0h@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKw5kFQdjGkX+xUvRQK/gOhj8KcwG8ElzX1lsJf+D6wVTEPHe
	J75YsFdsrnPlF6z+Ijig/EvX+DhHxG+Y1edbNN63bbIETjcjMYUNa1kmQoDeNHUAqg==
X-Gm-Gg: Acq92OHXT6QBrpEJS+uovoCmnjBLTmu9tmgus7OFQQflvu0zbLWOrxRMe6rPZ+E0W+1
	MkzIX/xmbh583DZt704efkeNl6Trl5z7Z4CGAse03NMw1cTgZ/cuF9kpLOGJRvrtDd2Nl683VrV
	9WoGSq5oZN6WTStT1OwxNMS/RkBwGjAkSyeH6C/j9aky8nIKGgj/qhaYQUes0mxeDmqcx9IyKt8
	aK/guJ5uxcnrtnjLseBieR6H+iLa3V+xCOHAlVjrt4SrYgL5XiOA6csCsquqy9oHPXXpYpOwOv4
	BJoEwGNjRfcncR7To+wrodohH1BF2TMB7iGiE3tMQydTBQdT+5nbMsFE0EKsZ54ZDoU/opajUZ8
	51DcraOobGZODNhBsr3IXpAo0yp028Fcm7DrD5AV5SgXiaMdusKDkA8qgAi2jlk18iwKKF770/P
	Vwsb588cYz1Q1ztYbuALc8OKVqlncu5KPoNnGP55dBDRU5jo2Xage67qYiceZx
X-Received: by 2002:a05:600c:22d6:b0:48a:5618:b4d4 with SMTP id 5b1f17b1804b1-48ffd828d6emr1692195e9.1.1779122125101;
        Mon, 18 May 2026 09:35:25 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:866a:e549:273b:bc0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57944c1sm288997405e9.7.2026.05.18.09.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:35:24 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH 0/2] proc: protect ptrace_may_access() with
 exec_update_lock
Date: Mon, 18 May 2026 18:35:14 +0200
Message-Id: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMI/C2oC/x2MQQrDIBAAvxL23AUVDE2+Unow65ouCVHWEgLBv
 1d6HIaZGyqrcIV5uEH5lCr56GAfA9AnHCujxM7gjBuNt08smilV3DNtSS4sQb8WfaTg4uQXsg5
 6WpS7/G9f79Z+wvvYyWYAAAA=
X-Change-ID: 20260518-procfs-lockfix-part1-5dca2d95bc12
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Arjan van de Ven <arjan@linux.intel.com>, 
 "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779122120; l=1555;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=lADZGL1l+uV+dRUhIFGvk44P/1X//TbM0Q/BhApFkWk=;
 b=IwpfuQofLx1OaD/Oq+E+Ekv+BwOYk72drXWLQP391fiPqwH7SfjOaqsx9Fjg87efduRYWBxLd
 Ine6lmQsfUvC2OWy+okwbW5YXqypA2GqF7rISgDZkLkJKNNyTHDU5Np
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

My understanding is that procfs is effectively maintained by the VFS
maintainers (though scripts/get_maintainer.pl claims that there are
no maintainers for procfs because the VFS entry only claims files
directly in fs/, and the procfs entry has no maintainers listed on
it).

In procfs, most uses of ptrace_may_access() should use
exec_update_lock to avoid TOCTOU issues with concurrent privileged
execve() (like setuid binary execution).

This series doesn't fix all the remaining issues in procfs, but it fixes
the easy cases for now; I will probably follow up with fixes for the
gnarlier cases later unless someone else wants to do that.

I have checked that procfs files still work with these changes and that
CONFIG_PROVE_LOCKING=y doesn't generate any warnings.

(checkpatch complains about missing argument names in
proc_op::proc_get_link, but that was already the case before my patch.)

Signed-off-by: Jann Horn <jannh@google.com>
---
Jann Horn (2):
      proc: protect ptrace_may_access() with exec_update_lock (part 1)
      proc: protect ptrace_may_access() with exec_update_lock (FD links)

 fs/proc/array.c      |   6 ++
 fs/proc/base.c       | 159 ++++++++++++++++++++++-----------------------------
 fs/proc/fd.c         |  27 ++++-----
 fs/proc/internal.h   |   2 +-
 fs/proc/namespaces.c |  12 ++++
 5 files changed, 97 insertions(+), 109 deletions(-)
---
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
change-id: 20260518-procfs-lockfix-part1-5dca2d95bc12

--  
Jann Horn <jannh@google.com>

