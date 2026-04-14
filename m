Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D198248166
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201445; cv=none; b=QNqZGMBojjo1kAnmFhoD6aqlCg+QK8COy42RJR1VZQ9ifZ8M8Q0FKxYxYqK3GXez7JCW0R5hBdDH+zK6lseSYasdxJSFyo4vJYiu25blUzsCiZQDkBk0Zx6HdXzAUQjCSt7oj+CHFFiUxHmoyBTQ3ID4aJaDHn5dRcJjDi1BuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201445; c=relaxed/simple;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I9H02PfR7m59bQmEHuGi6t7zeabA7T1HbmuuOefU7dJURVqw5C9Las1sPB5A/iwDipt6ImqzJTncCmEExNgEpkqhTBTKxPLBVh77KuMvaqzqh6d6Cxz+8iWW8zKsKFKkKJOmwfJrw1HnQhUyzWbUZKclQCx2ipMJyukJQ26txpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-41c07bdd2a9so3011530fac.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 14:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776201443; x=1776806243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=Midp7rVTYFKs8/WXJOPdj7jeUUItdf8jaXIqy4nd3AFHp8JEBxypq0yKclPrblCOP5
         OhaD1Q2U6rXdehYeKQS+HV6g2hWfa9cPB7+9olQvP5L777duxQm11D3lrf2vGTp6FenU
         U5Pimfoh0Mueubl/dSAO8d4hQTcCpjtIa5B6nDNkMlQ2zv7Cl6ZdqGEQAzjMoVvWMfJD
         xCXlNodbREI+MLDi0WFVdCQb46DqOtxXnutVmuYp7oyfZZIbbrl+bGnkuE2dvdW2Lcev
         Extz9Up3l64xOsgyKpjC0+tRvZNX1a0cRJj/PnoMfybuH4fVmMgrA9tOQkw7cHe37kKs
         xcRw==
X-Forwarded-Encrypted: i=1; AFNElJ+wodJXRp/3pHizyqtFMWO4Kiiw36/n2YtPKrMAvbqhTTLZOPB7yRKJfuIoSyRYGIldOCAu7Qf49h8pePli@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMvzsgs+ldVwlAuk7Y+tZSgrO66oleaSBtIhdHt9nsmMfUX+M
	h6kcYT2v7SmnTSQHGOLhrvmEh66XeIMPWKswTff6YFZlYQqJ0XYoDwr5RPCy87cLtf1eLd1pL4j
	0sbRViu/UwNUPhVMbIV5VQ+xyUXydGMR/Rf62cAx/UB6SbW3pLJ7QrqlutE0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:310a:b0:687:d4de:1f9d with SMTP id
 006d021491bc7-68be652da4amr9513114eaf.24.1776201443518; Tue, 14 Apr 2026
 14:17:23 -0700 (PDT)
Date: Tue, 14 Apr 2026 14:17:23 -0700
In-Reply-To: <696f61f6.050a0220.4cb9c.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69deaee3.a00a0220.468cb.0064.GAE@google.com>
Subject: Re: [moderation] KASAN: slab-use-after-free Read in bulk_make_private
From: syzbot <syzbot+c0fd9ea308d049c4e0b9@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzkaller-upstream-moderation@googlegroups.com, viro@zeniv.linux.org.uk, 
	ytohnuki@amazon.com
Content-Type: text/plain; charset="UTF-8"

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
