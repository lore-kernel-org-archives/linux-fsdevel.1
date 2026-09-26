Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC30371868
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790412016; cv=none; b=Ne7gqHtZNPigFM2Kxct5pHOBhpL2dzNvYiGcShxypPeogu/+rcb1R6JUa/0NR8OA/IpOhoQ+unzw3k/ADvLAg43sYXT9bNzzjvk0BnVCamLDotFsgWcNHdFwrPDISwA6yzaL4B0CtcP3UBvn1GnyME2juqfVVa3szYUlYZhxIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790412016; c=relaxed/simple;
	bh=KD+eY6dK9vZV4HJuH1usyae1U74elfdQ2Pdz04BwUyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iPBT+8s1oD3eZTVohdEb0CYg+zOpiZ/ItsvKlgSevMWnChmUlQ2mAe0B/j94CEuOpZN/lvXHo4g83GYeEK+x6Lo6UMd+/2sbv/jK5ZVCCUsCjcKOnnlMMOqzDCdDhr5W6kIC1iOHd/TpcsD/VKflrvDpSbawkxRvWiwR3PbKG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8vXmUsT; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8vXmUsT"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d07so1347289c88.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 01:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790412014; x=1791016814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rW8cFDq/XM211Gv3CA+1i+N4Sbl2j4STP1v6kSNU3m8=;
        b=d8vXmUsTtETQKLD8rXh+Lx9rdNd5iwC86m+teomIg6HBkJDuPAEIXz6FFZUoHEiI02
         CN2TjWON3kKdYsV1giY1eLivdvxGXa6DELqePMdw07fSpeR+9kQeIHUiZwF4fGbCtQb7
         3w6wfOcA1aglRdercBjHqKIm7zzRuENptqs15AM0HanJSdQ1LVKv+r4s/QFQqOH4J/jZ
         CfTXtNrFFo/lMZmb2dS9qo71urwZV5NuaVxzGxK6Y2TOmwA3cyste+JdyY8EV/1rWFQQ
         JxDIxvSDp0JHdUJqD2ulRefQbGe838MyMQYccUxoHZih/M4iYE/MGT6lRQ55NRLJKwq5
         ihYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790412014; x=1791016814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rW8cFDq/XM211Gv3CA+1i+N4Sbl2j4STP1v6kSNU3m8=;
        b=EqbUQMBqDM4+Zz7c+35UNMRgjyeATFiwCZD8eceLUtTel9vhdQisPgcCKc0Yaufhcz
         Pb7Pb6rcuEeUr2axUnOMdVGscYkTlxQRkvdWEFOC5rLc6i6mcqR9nLVZUlsqiLM6gFYf
         dkdmsN+xi6C2AmKODy5wc0WhMhNRgytSnElZ0wB/tgA4SajO76W46Ck+aao9ozyDY6hN
         0Mf+b+9UvygzC028uXoV5VxMVCCH8oT6z4lHVGftQsOGG0mYPi1zASiq1k/nYGnoSRpW
         apqxuVFQqfKmUapGGdyg3ABYppKV4OsmH+4XOQyQnmsTvBRAZx5YEt1mhEhcLoKter1k
         QgDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzKhcwt3fgGeuXg6lloR2lk726J+5Vfb/FSo/mvJqGYQRdmVjx/agpF79JObZXuNLsdeuOqP200FEEuF3Z@vger.kernel.org
X-Gm-Message-State: AFuF++mGIQ9gZbdCn2+XhvuZtavLbxMYStyBH5PxHBPxNVcJoKaXEzu0
	7WjXLdPGUHpJ3nIuTdPZA1yXH6xIFWC8yotqNi4zcZd9al5ivHg8gHYU
X-Gm-Gg: AYBFou3a7t/rjCYh9yGtKj/6Toaq2DOGBkCanMKEO5WAOqemkm+MT3AIQ+AFXPHOuIF
	nfimAop0gayp6w53ttJ4FTaCVIouH1E7teYjU1gkp+CcWgc1OurqaUUzhxtiG3tA+SQ0HyF7/g/
	i9h8fZuQdQCAjsFFLr/LUzyhBnF73doQuPYJi2Q9pxi3JRvdbx1qKrl8uUe0ZgD1fKeEeyR6qBb
	q7BwuUrzbG60IBZmlHNH5UWoDB7uLntxhbJIZclYi+mYgB1wmI76iV87H80A+MsY0GtyKcgk6DJ
	+sZnY+CtmXUtYjQvOBWNXLer/RZatvg7odzclC7xkaS+Ih2+SMT+tcNCTEReDfFKBVwMdVelxDN
	ZtgWUXa+NZ1fiZRwhcu/TQLAfTN7FS949xVnjZeVrO6jlkfaeMocvVStHw6Bgka0SZfY57rTh1F
	VXC2klcAZvrNwZ4vSgt6ePEPHVSgTXB+NjmhCH9/zGr5TcdpQYxOPKREXWSSFdXJ9QeazCnZHTg
	OHaUPM2owX4B5IMo6OtrLMxS5GG7S3WLyBOx2cRUDdlLQJfIOUenfXzMEme9gT29P4SJd/EQNfa
	8IGejero8H0FExFUob+LIATAmRDzMdTjF8bzWINUEU6P+SIWzfI0gRhsguEJHeIWy793Bw==
X-Received: by 2002:a05:701b:4509:20b0:143:5722:55be with SMTP id a92af1059eb24-146cfdd2918mr2198164c88.30.1790412014376;
        Sat, 26 Sep 2026 01:40:14 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm10487044c88.0.2026.09.26.01.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 01:40:13 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hfs, hfsplus: bound the partition-table and wrapper hops
Date: Sat, 26 Sep 2026 16:40:08 +0800
Message-ID: <20260926084010.569552-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_mdb_get() and hfsplus_read_wrapper() follow a partition table, and
hfsplus also an HFS wrapper, back to the volume header with no bound on
how often.  A partition entry or wrapper descriptor with a zero offset
sends the loop back to the header it has just read, and a crafted image
hangs the mount.

These patches allow each kind of hop at most once: one partition-table
hop, before any wrapper hop, and one wrapper hop.  TN1150 requires a
wrapper's embedded volume to be HFS Plus, so a second wrapper is never
valid.  Apple documents no nested partition maps, and neither macOS nor
the boot ROM reads one.  With both limits, plain, wrapped, partitioned
and partitioned-then-wrapped volumes still mount under QEMU.

If you would rather not rely on that, the alternative is to reject only
a hop that does not advance part_start.  Both hops add unsigned offsets,
so the loop then always ends, but a crafted chain of one-sector hops
can cost a synchronous read per sector of the device before it does,
which on slow media such as a CD adds up.  I can send that instead.

Matthias Goergens (2):
  hfs: bound the partition-table hop in hfs_mdb_get()
  hfsplus: bound the wrapper and partition-table hops in
    hfsplus_read_wrapper()

 fs/hfs/mdb.c         | 10 +++++++++-
 fs/hfsplus/wrapper.c | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.55.0

