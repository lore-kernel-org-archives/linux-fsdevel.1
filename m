Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6067145A05
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770727810; cv=none; b=DgXAtrHAnEFfdwQ804sam+Y1yP2ZrJn7r3QujEVOTak4dlhu550QOUCOdD7KmDfUJeJYX4nHkFRZMRbugXCRrQz7Jfaso90kXtWVgEDY6LkoLmehlPo8lytU5QpOv3zXEsAuhX+iJAcGrwfs9FFbOpsuNJrb4OJ8Q4O1iaLdI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770727810; c=relaxed/simple;
	bh=i4rImYNlFIZ4z2P59cmXkVuEnMG4ZV7IFAHBBh+pQTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gp0jO1XqUQW8vKyEwdVYQQd7MyE4z2fNmk4xiLSYiw9rEXVZ1yVZ+c3T7fHGdl32t1hoUlSgZNZdekyaXkW2ibzm2QBL8VY1WbArajai1NmBTHvjkMxKliHnw79kmeiDF0HFNYkednZm2S2HmvQ7cRMqlKSCtP5Ud/EjUXTeG1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61ACnvUL067899;
	Tue, 10 Feb 2026 21:49:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61ACnu6B067896
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 10 Feb 2026 21:49:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a6c8ffeb-9e82-4cb9-b79c-2ab9dc330994@I-love.SAKURA.ne.jp>
Date: Tue, 10 Feb 2026 21:49:56 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [git pull] HPFS changes for 6.20
To: Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
References: <6dd35359-3ffa-8cd5-a614-5410a25335c0@redhat.com>
 <CAHk-=wjmFiptPgaPx9vY3RG=rqO452UmOAPb1y_f9GQBtuJVjg@mail.gmail.com>
 <0a4797ab-07a5-11ef-074f-19ad637f84ea@redhat.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0a4797ab-07a5-11ef-074f-19ad637f84ea@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp

On 2026/02/10 20:21, Mikulas Patocka wrote:
> 
> 
> On Mon, 9 Feb 2026, Linus Torvalds wrote:
> 
>> On Mon, 9 Feb 2026 at 09:01, Mikulas Patocka <mpatocka@redhat.com> wrote:
>>>
>>>   hpfs: disable the no-check mode (2026-02-02 18:06:33 +0100)
>>
>> This looks like a totally bogus commit.
>>
>> If "check=none" suddenly means the same as "check=normal", then why
>> does that "none" thing exist at all?
>>
>> None of this makes any sense.
>>
>>              Linus
> 
> I wanted to keep the "check=none" option so that I don't break scripts or 
> /etc/fstab configurations that people may have.
> 
> If you don't like it, you can drop it, it's not a big deal. The syzbot 
> people will have to deal with it in some other way.
> 
> Mikulas
> 

I posted "hpfs: make check=none mount option excludable" because syzbot is not
the only fuzzer. Making it possible to exclude using kernel config option is
beneficial to all fuzzers, and we can check whether the kernel config for fuzz
testing purpose is appropriate.

But if you can accept making check=none to behave as if check=normal, I would
suggest the following change.

 fs/hpfs/super.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 371aa6de8075..18c8ba6e9398 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -615,7 +615,11 @@ static int hpfs_fill_super(struct super_block *s, struct fs_context *fc)
 		if (sbi->sb_err == 0)
 			pr_err("Proceeding, but your filesystem could be corrupted if you delete files or directories\n");
 	}
-	if (sbi->sb_chk) {
+	if (!sbi->sb_chk) {
+		sbi->sb_chk = 1;
+		pr_info("check=none was obsoleted. Treating as check=normal.\n");
+	}
+	{
 		unsigned a;
 		if (le32_to_cpu(superblock->dir_band_end) - le32_to_cpu(superblock->dir_band_start) + 1 != le32_to_cpu(superblock->n_dir_band) ||
 		    le32_to_cpu(superblock->dir_band_end) < le32_to_cpu(superblock->dir_band_start) || le32_to_cpu(superblock->n_dir_band) > 0x4000) {
@@ -632,8 +636,7 @@ static int hpfs_fill_super(struct super_block *s, struct fs_context *fc)
 			goto bail4;
 		}
 		sbi->sb_dirband_size = a;
-	} else
-		pr_err("You really don't want any checks? You are crazy...\n");
+	}
 
 	/* Load code page table */
 	if (le32_to_cpu(spareblock->n_code_pages))

