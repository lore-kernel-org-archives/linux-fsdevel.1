Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB133F8D9
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jul 2026 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783256259; cv=none; b=JdpREuT7t6+LccIZAtikhozZAp9+hukHGvdbxYTEuKktcNgU5JGEtDgh+36J5TW7hq6f79HFT0jww3WrmzcLmdRLvpmVbP7gcCKgQOPTevOZrwwK/rUHp98vC2MdgBGb0WeNKX23qh5GRQjoCJ30AxAcNEQBJA5gu7f8tc4EuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783256259; c=relaxed/simple;
	bh=cW4B+RgqYWn7EqVQ/177xDYC+CH9X9rVzpcB0f1YwtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiDGM4AZlETGXn5XlWsCAkkq2WqNuv+5ZPY/gujvtuXxtKtBdESkXhmXuFSQKbyOHKSgEXVH0un6g4gxCu639IcXlIfmcC2RfkdV2kHXbfbz/da6WTf7taDzMv4Nc93Wh8Ibc+wSyuAMLSuRgnrTZtqLu0594l4Az0WRYm0hKvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwWaUXgB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwWaUXgB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so20648185e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2026 05:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783256257; x=1783861057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAYUJGMfYh/BJn1YwzwjYIE3heddiUOoScF80A+TDdQ=;
        b=QwWaUXgBK8TTORURuP4nmX/x21HxeOy7FMPJfWg+ufwggRQfM8kl1/vdwaZXztJn4S
         fYtWctdOyB05F37eEbCtvJxsvb+ONuFikaMt5M1Ap0oKkHf75B2NibjyUN3zDrrQjXbU
         6+ADDMy7dHGVvWuuxEK2lr4eR+XJHcW4CG6qo48fn8M8pdPoKJ1btj3SWHRZ3oxo927W
         Igq6eYaaM3bZhO07y6hRRiS2nI1+XvCLME0tLwqY2feCNFchTrynzj/pEt0D7oiiAs29
         6dgMZD0m7QE3DiQwjI20VLPzxu0tTnxVxzE0v0L0W3LFdujSuh8jqog2slx7x8PSJzpY
         X/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783256257; x=1783861057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lAYUJGMfYh/BJn1YwzwjYIE3heddiUOoScF80A+TDdQ=;
        b=g4SZ/5Vfk8dtsaUJMBtPopnzwOvminAg6PdC2U4H3MADbcKnyj9cCaybtl27NSnOew
         n0FQxfIfNijf59OzV7WKY3yU+MTuX130wkALeSrYNqaBYdn80mI6BM50Nd9ae1Bd5Tb6
         CY0CmubDTgGGc6NjNpP1/VMWy6RGD5iExj2ngCkBpdDQoUgYaMDxI1AmIoYwYTfrBZ3k
         VYaXmvIT9UYcT5/yL1M/hQoFYftjqNxd9xPOvnBkNHWgXKC95d7fiMsl9QOoAYhQ8el/
         3Dia1KCbs0y8PfBkmHE/20qbbz1I49nCp3uX21jeW4BT3B8oZghOzGaNqb5lw4lkCJYB
         0QCA==
X-Forwarded-Encrypted: i=1; AFNElJ8GrdxFC63bm0kG9gfaoEkKO/VqA7tt41PGIGqBXJV0bcrrdfr9eyXR77LsIskJJsEpaWw8wCoG7QCGxk/1@vger.kernel.org
X-Gm-Message-State: AOJu0YyUiFeqUJq9myXXvjeDP9I6sLLxL6+ZSunoJO9Cj7q/rC4SmAfe
	QtvAEalx+l8fAbh5xW1LP68BSSeZf9nmcRVoVNN2PqHQ0PI/mvxxvGBn
X-Gm-Gg: AfdE7ckWGEz5MR6cWty+2CZ0dtvBt9RAdUOu7N550q4XH3UwH72mUMWu/OXDjhdVI8Z
	fE0zTWEvlAC8/5yQkLP/qNTbqu9O2CG4rHZWWGMcyiD5qECz22SG2OTx+4qj0Xbu2UqqOW9+jT4
	9UD/cUl6+IjYNVPv2PGOJrsdOopqVfsSwsKkA2E/wkfvEIralcSL2Zt8vOdWkNyoJIqSNIzoTmP
	fnCqZjZN09F4iVS7PKDyo2waW38o7w9ASU7+Sjjaec0D8COip0Cfk5E0C0bH3b97Jjy9QU7OyLv
	utNUKJ4zsJVePN7I9niqeY2yjwFOmqrCzxYUbYXHBYsfMXgzHDsddVwxUVINzdwlndH19km8KD/
	c+yytCbWT3HmNcXDk2T1KH/qBAKbWsdVRlsfo26PNSice87jU+ydb4Xb2MJmTGB4yWeS3X9p9Ch
	X2Eop8AwGd33fvj8RajRA=
X-Received: by 2002:a05:600c:46cb:b0:490:9588:bdb6 with SMTP id 5b1f17b1804b1-493d11f6b4fmr86422645e9.33.1783256256490;
        Sun, 05 Jul 2026 05:57:36 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47a9de1e736sm17876979f8f.7.2026.07.05.05.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 05:57:36 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: jack@suse.cz,
	jannh@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC v4 00/25] fs,kthread: start all kthreads in nullfs
Date: Sun,  5 Jul 2026 15:57:13 +0300
Message-ID: <20260705125714.764184-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian Brauner <brauner@kernel.org>:
> So this is a bit of a crazy series. When the kernel is started it
> roughly goes like this:

You mention "nullfs" in comments. But we now have two nullfses:
for kthreads and for userspace. And it is not obvious which you mean.

For example:

+ * Be aggressive about this: We simply reject operating on stale
+ * fs_struct state by reverting to nullfs. Every kworker that does


+void __init init_userspace_fs(void)
+{
+	struct mount *m;
+	struct path root;
+
+	/* Move PID 1 from nullfs into the initramfs. */
+	m = topmost_overmount(current->nsproxy->mnt_ns->root);


So, please, create two terms for referring to these two nullfses and
use them everywhere.

Okay, I have to admit: I found two uses of "nullfs" in comments only.
But I still think that having terminology is valuable. For example,
for documentation.

-- 
Askar Safin
