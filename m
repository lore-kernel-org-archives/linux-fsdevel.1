Received: from mta1.migadu.com (out-155.mta1.migadu.com [95.215.58.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F0732ED4E
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401478; cv=none; b=I4X0hrek32Ew6kyjz3L/LufnxWYmVKZ+3SlYdSTOKcZacbVUOWc8qxgWyzzYEVqHl/1APdWh9rCgDTn7Od/t1dGFNSIA9Ku1J7tTts67hRO3ApMCiVoyGQc8hDKh73en4AjqdIuwhyzBlh/sTOuHgtYr8ugwf6ul15CAVEUVK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401478; c=relaxed/simple;
	bh=Jd21OGQ2RfGt/VsDcHXRvekghYIMUrR35JIlYJ9JswM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SW3CFizVL4yz1ySaBWlRvZ0zZJHQI5ts9wD0GgGpK0HsAxYT6/VQySGfepFhUnycDdYas+U3AcNMEzb8LxyaPMMrRNDBiTv2VAw2mRgGLta3WnxyyP18KJEqwEOzdNdZSj2+gu+G59afe3lceXbTidDPBuGHWrVz6kUhNv3z50s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K1lcooxT; arc=none smtp.client-ip=95.215.58.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K1lcooxT"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Jd21OGQ2RfGt/VsDcHXRvekghYIMUrR35JIlYJ9JswM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788401471; v=1; x=1789006271;
 b=K1lcooxTQyAo4k4PUQoMFp6wMiUB8uA5GOWZ0xv0en1zM9SzAh/jmha6cl5XMIwUS0Fl7A6+
 PtJ0/OB7ptTNWInLrdi0AkGH7Q/ssT8FZEIwRwHwG7Fchik2LdaxhWic8i1bdTIYBgiAxIMWHmD
 yexQaVfs9PpMMnqzQNGdWSz4=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4eb3a4d57710aaab;
	Thu, 03 Sep 2026 02:11:11 +0000
X-Mizu-Trace-ID: 4eb3a4d57710aaab
X-Migadu-Flow: FLOW_OUT
Message-ID: <5eb2ec0a-e6d6-4cae-89fd-6e68f75a64cc@linux.dev>
Date: Thu, 3 Sep 2026 10:10:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, alex.aring@gmail.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, linux-kernel@vger.kernel.org, avagin@openvz.org,
 khorenko@virtuozzo.com, bcodding@redhat.com, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2] fs/locks: filter OFD locks from /proc/locks for
 foreign pid namespaces
To: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
 cel@kernel.org
References: <20260902125139.975253-1-cui.tao@linux.dev>
 <ab253791f92c329865168c4734c9bfe2f8537a5e.camel@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <ab253791f92c329865168c4734c9bfe2f8537a5e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Jeff

在 2026/9/2 21:03, Jeff Layton 写道:
> On Wed, 2026-09-02 at 20:51 +0800, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> Since Linux 4.9, /proc/locks only shows locks whose owning process is
>> visible in the reader's pid namespace.  The check cannot see the
>> owner of an OFD lock, though: locks_translate_pid() always returns
>> -1 for FL_OFDLCK, so an OFD lock held outside of that namespace
>> bypasses the filter and is shown with its device/inode numbers and
>> byte range, e.g.
>>
>>     4: OFDLCK ADVISORY  WRITE -1 fd:00:70536961 0 EOF
>>
>> This was observed on a Kubernetes node: a pod reading /proc/locks
>> listed the OFD write lock of an unrelated host process, while the
>> POSIX locks of the very same process were correctly hidden.  The
>> device/inode pair identifies which host file is locked, the byte
>> range discloses where it is actively written, and the
>> appearance/disappearance of entries reflects host task activity,
>> contrary to the documented per-pidns visibility of /proc/locks
>> (proc_locks(5)).
>>
>> OFD locks record the owner tgid in flc_pid, so use it for the
>> visibility decision in locks_show(), mirroring what
>> locks_translate_pid() does for POSIX locks.  The pid column is still
>> reported as -1 for OFD locks; only the filter decision changes.
>> Remote locks keep their negative flc_pid and stay visible as before.
>>
>> Verified with an OFD and a POSIX write lock held in the initial pid
>> namespace while a process in a fresh pid namespace reads /proc/locks:
>> the OFD entry is visible without this patch and hidden with it, the
>> POSIX entry is hidden in both cases.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>>
>> ---
>>
>> Changes since v1: keep remote OFD locks (negative flc_pid) visible in
>> non-initial pid namespaces, as locks_translate_pid() does for remote
>> POSIX locks.
>> ---
>>  fs/locks.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 6e4ff7fcec05..4af1385682e4 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -3022,6 +3022,25 @@ static int locks_show(struct seq_file *f, void *v)
>>  
>>  	cur = hlist_entry(v, struct file_lock_core, flc_link);
>>  
>> +	/*
>> +	 * OFD locks are reported with pid -1, so the filter below cannot see
>> +	 * their owner; flc_pid holds the owner tgid, so filter on it.
>> +	 * Remote locks keep a negative flc_pid and stay visible as before.
>> +	 */
>> +	if ((cur->flc_flags & FL_OFDLCK) && cur->flc_pid > 0 &&
>> +	    proc_pidns != &init_pid_ns) {
>> +		struct pid *pid;
>> +		bool visible = false;
>> +
>> +		rcu_read_lock();
>> +		pid = find_pid_ns(cur->flc_pid, &init_pid_ns);
>> +		if (pid)
>> +			visible = pid_nr_ns(pid, proc_pidns) != 0;
>> +		rcu_read_unlock();
>> +		if (!visible)
>> +			return 0;
>> +	}
>> +
>>  	if (locks_translate_pid(cur, proc_pidns) == 0)
>>  		return 0;
>>  
> 
> First: I think this may be the wrong place to do this. Why not fold
> this change into locks_translate_pid()? It seems like we'd have
> inconsistent results wrt lock visibility between /proc/locks and
> F_GETLK if you do this here.
> 

Good point. I did consider that.  My hesitation with folding it into
locks_translate_pid() is that posix_lock_to_flock() also uses it, so
F_GETLK/F_OFD_GETLK would then report a conflicting OFD lock with
l_pid = 0 instead of the -1 that fcntl(2) documents for OFD locks.
That's why I kept the check in locks_show(), where it only affects
the /proc/locks view.

That distinction isn't introduced by this patch, though, since it
already exists for POSIX locks: since the 4.9 pid namespace filter, a
foreign-namespace POSIX lock that blocks F_GETLK is reported there
with l_pid = 0 while /proc/locks hides it.  v2 just gives OFD locks
the same treatment.

> Thinking about this some more though, I wonder if trying to hide these
> locks is the right thing to do. These locks do exist and they do block
> you from acquiring a lock. If you go to look at /proc/locks and don't
> see them, that seems confusing.
> 
> Would we be better off showing all the locks and reporting the pid as a
> negative value for ones acquired in foreign namespaces, like we do for
> remote locks?

That's a reasonable alternative - anonymizing the owner instead of
hiding the lock does have precedent (fdinfo follows that model), and I
can see the debugging benefit of always showing locks that may block
acquisition.  I went with hiding because it preserves the /proc/locks
visibility semantics introduced in 4.9 by making OFD locks consistent
with POSIX locks.  With only the pid anonymized, the output would
still disclose which files are locked and the locked byte ranges of
tasks outside the reader's pid namespace.

If the consensus is that /proc/locks should show all locks with an
anonymized pid instead, I'm happy to rework the patch in that
direction.

Thanks,
Tao

