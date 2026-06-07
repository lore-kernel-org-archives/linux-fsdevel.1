Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9901DA23
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 00:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780792450; cv=none; b=rjAgr4TMxDw0XDVONI5L8P5r9WX7LRDek7I0P90F1Wh1ZtYJldOFYjwAmnA87fjicMVyzDI9avhQahLeDlEFHbRwG3b+SARKDaoe/ZPoWTlC+WED2r/Qgg1CA/PhCQ45UhZM34E0i9veargdy1JHFhluOHc0I4eHnN/oRYdlBys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780792450; c=relaxed/simple;
	bh=dlUYTjJYy7R0LVfLvSZtLDvFq4tCv9tL9hwv8/ImWNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EeXA+oqqztvNPFA5rT4hoEitD8FJFWi+hE3SP+UzJvoZO/UWRfv/8v9RexSmIKe3ZwxtBwKbfnWIY3zzk28x4wZc3GmfWIlnUmLLlWl7+7XOjZER5rSwhX00uneNY3RgQ8B3gVaJedeyivyi2ZdL1JmoENMv1kyq3p8KSRlDpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU8KU7Jr; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU8KU7Jr"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-135e7f4a295so1774500c88.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 17:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780792447; x=1781397247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jEqjbY4JN65tlgXqO8SQjQXozIpRYv+t+sS2oLP8pcw=;
        b=RU8KU7JrNraF+1wQ0D//qAl2KBlz9N6qJWRtONv8Pb9Ulwgxfat30jwGE5e7ImeCii
         SellMqbODPXzgryA0tnsiU8O2xQMgYt/Obt6mr+iLSZtukuKwnfoc+sZNh5C44Bfv2F8
         ztXfr6lCdk3CNYkhYw3uuG/bVisMXee1myqKjMrrKmh8q+x1gV41xdfUs7dD2MZboYcV
         NdhoeqefAV41v13pCIxzYsM7w7AZ8LotgSJhgwEx3lmy5o3E8r8TQoqESFdpR63miiQp
         B85mM76186mJuZKGbuaBXsJTZogvgkVTnUx7E8TnWn9VYyIyHcrc9gOvOlClS8+nJsON
         EFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780792447; x=1781397247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEqjbY4JN65tlgXqO8SQjQXozIpRYv+t+sS2oLP8pcw=;
        b=qqf//lK4q8x1gKtnrCqFVINrtLn+A1zJ63q1uWCkH4QP4Gk5zgwMSNY6tWAlAn3uCZ
         78t+RnHSaUM47TsGaUU1G/QNZ30OckO9FWJm1enMKz8zBfdHZUWzvFkOtTScM8faK649
         /k62q3rUZVc8IfeSxHt42iuJpO0L1PjJhevmh+YmIFY34rkC86rYNvH66l7bkOIfK+xL
         Et3Jxf/GWpGfJ9g4kfk3N7iLz9nSgdTnJQp4Dk152V8wovVGWY1HWqdM8JmlNLhP4Ce+
         DvitmUVPPXbsnbCt35kYZmoIOEzUO6/92sALPwTzFYa+SEiKsJxHExDOvRdM4/Hgcq5h
         icww==
X-Forwarded-Encrypted: i=1; AFNElJ9nwaUppIAMCtuKHQiBBsdE5Z6eL3+UEQm/uTxwfGk3d2Wi08ThcedmaYbb6cebdMG4eH6POfNnfTl1Q8kv@vger.kernel.org
X-Gm-Message-State: AOJu0YzwmWl9jp3vPI9/1LQMYhpY5dI3Uvclz7kL/Dji5v9qthvNf6Ly
	KeeZHQhLhBzOm/HowZcH5PeMRGbQWnRWVswjrRG4jwGSx8D8M0NJ2oh1
X-Gm-Gg: Acq92OF64s2sT1a40qVC8z4FWM6cttCW+Mx9ky02UIC+zbppBXjjLS29iyU99Q8eHVF
	4ULPOkNvA+We8TR4/2Vy7VxxOF0edq3AdBwk9LU68vMe6vRnFqHmfJ3EpBZAMGruZscvjqXDagu
	ZvsmbEhiB3wVZb8cCZHWX+lD4aouY8QwB/y35RMrjmbglqapkTgxDzBnZCHxMi8FaJZf+sXbVZx
	w4px976otqRrBLg8cXTs+1ii/wgjcK7K2h4ggb+qvCgNz5Ago95wL+EPT2eY1/SBLPKaB5T+3al
	Sq/MtidiF8+Ra0rMvOZrm8qDU1GBIgtFxHFNZFdmUfmFUwocjgu+zpLkCTFgQsV0z8DipEHWRTg
	B2uSPJhcyj7Iv2gE0fNXa4E+xjBmGMR56Ney7w51ZB1SxmKrYtPXfHEmHvEW7XUWFzsYiKoa+dZ
	MRLOXvh0u4t8qwdRC04id+NLXL47DNzQ==
X-Received: by 2002:a05:7022:2201:b0:137:edae:540e with SMTP id a92af1059eb24-13807d187demr4136510c88.6.1780792447282;
        Sat, 06 Jun 2026 17:34:07 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f716017esm13451383c88.15.2026.06.06.17.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 17:34:06 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [PATCH v5 0/2] fanotify: lift pidfd reporting restrictions
Date: Sun,  7 Jun 2026 08:33:41 +0800
Message-ID: <20260607003343.425939-1-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pidfd API now supports pidfds for tasks that are not thread group leaders,
but fanotify has not caught up yet. This patch set lifts that restriction and
allows fanotify to report pidfds referring to the event-generating thread.

Additionally, this patch set allows fanotify to hand out pidfds for reaped
tasks by registering the event pid with pidfs when pidfd reporting is
requested and dropping the pid_has_task() check before the pidfd_prepare()
call, as suggested by Christian.

Link: https://lore.kernel.org/lkml/20260528-schmuckvoll-heilen-garen-be77b4208671@brauner/
Link: https://lore.kernel.org/lkml/20260602-patzt-sturz-segen-f1f305d61b75@brauner/

Changes since v4:
 - Add a pidfs_register_pid_gfp() helper function to pass in custom flags.

v4: https://lore.kernel.org/lkml/20260603001516.26234-1-anonymemeow@gmail.com/

AnonymeMeow (2):
  fanotify: report thread pidfds for FAN_REPORT_TID
  fanotify: allow reporting pidfds for reaped tasks

 fs/notify/fanotify/fanotify.c      | 17 +++++++++------
 fs/notify/fanotify/fanotify_user.c | 33 +++++++-----------------------
 fs/pidfs.c                         | 10 +++++----
 include/linux/pidfs.h              | 18 +++++++++++++++-
 4 files changed, 41 insertions(+), 37 deletions(-)

-- 
2.54.0

